# nvm is a sourced shell function and cannot mutate a parent process, so every
# invocation runs it inside bash and reads the resulting environment back out.
const nvm_environment_marker = "__NVM_ENVIRONMENT__"
const nvm_exported_variables = ["PATH" "MANPATH" "NVM_DIR" "NVM_BIN" "NVM_INC"]

def nvm_directory [] {
    $env.NVM_DIR? | default ($nu.home-dir | path join ".nvm")
}

def quote_for_bash [] {
    $"'($in | str replace --all "'" "'\\''")'"
}

# Run an nvm command in bash and apply the environment changes to this shell
export def --env --wrapped main [...arguments: string] {
    let directory = nvm_directory
    let script = $directory | path join "nvm.sh"

    if not ($script | path exists) {
        error make { msg: $"nvm.sh not found at ($script)" }
    }

    let bash_script = [
        $"export NVM_DIR=($directory | quote_for_bash)"
        $". ($script | quote_for_bash)"
        $"nvm ($arguments | each { quote_for_bash } | str join ' ')"
        "nvm_exit_code=$?"
        $"echo ($nvm_environment_marker)"
        ...($nvm_exported_variables | each {|name| $"echo \"($name)=${($name)-}\"" })
        "exit $nvm_exit_code"
    ] | str join "\n"

    let result = do { ^bash -c $bash_script } | complete

    let sections = $result.stdout | split row $"($nvm_environment_marker)\n"

    if ($result.stderr | is-not-empty) {
        print --stderr --no-newline $result.stderr
    }

    if ($sections | length) > 1 {
        $sections | last | lines | parse "{name}={value}" | where value != "" | update_environment
    }

    if $result.exit_code != 0 {
        error make --unspanned { msg: $"nvm exited with code ($result.exit_code)" }
    }

    $sections | first | str trim --right --char "\n"
}

def --env update_environment []: table<name: string, value: string> -> nothing {
    for variable in $in {
        if $variable.name == "PATH" {
            $env.PATH = ($variable.value | split row (char esep))
        } else {
            load-env { ($variable.name): $variable.value }
        }
    }
}

# Switch to the node version named in the nearest .nvmrc, if there is one
export def --env nvm-auto [] {
    let parts = $env.PWD | path split
    let has_nvmrc = 1..($parts | length)
        | each {|count| $parts | first $count | path join ".nvmrc" }
        | any { path exists }

    if $has_nvmrc {
        main use
    }
}
