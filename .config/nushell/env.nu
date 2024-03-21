# Nushell Environment Config File

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

def create_upper_part [] {
    # prompt parts

    let time_part = (date now | format date '%x %X')
    let time_part_length = ($time_part | str length) + 2

    # cmd part

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {
        ["code " ($env.LAST_EXIT_CODE | into string)] | str join
    } else { null }

    let cmd_duration_ms = if (
        $env.CMD_DURATION_MS != null and ($env.CMD_DURATION_MS | into int) != 0
    ) {
        ($env.CMD_DURATION_MS | into int) * 1000000 | into duration | into string
    } else { null }

    mut has_both = false
    if (
        ($last_exit_code != null) and ($cmd_duration_ms != null)
    ) {
        $has_both = true
    }
    mut has_something = false
    if (
        ($last_exit_code != null) or ($cmd_duration_ms != null)
    ) {
        $has_something = true
    }

    let cmd_part = if ($has_something) {
        ([
            $last_exit_code
            (if ($has_both) {" ~ "})
            (if ($cmd_duration_ms != null) {"took " + $cmd_duration_ms})
        ] | str join)
    } else {null}
    let cmd_part_length = if ($cmd_part != null) {($cmd_part | str length) + 2} else {0}

    # divider

    let section_divider = 1..((term size).columns - $time_part_length - $cmd_part_length)
        | each {|_| "-"}
        | str join

    # formatted parts

    let formatted_cmd_part = if ($cmd_part != null) {
        [
            (ansi reset) "("
            (ansi red) $cmd_part
            (ansi reset) ")"
        ] | str join
    } else {null}

    let formatted_time_part = [
        (ansi reset) "["
        (ansi purple) ($time_part | str replace --all (char path_sep) $"(ansi purple)(char path_sep)")
        (ansi reset) "]"
    ] | str join

    [(ansi reset), $section_divider, $formatted_cmd_part, ($formatted_time_part)] | str join
}

def create_lower_part [] {
    let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let is_devbox_shell = "DEVBOX_SHELL_ENABLED" in ($env | columns)
    let devbox_shell_part = if $is_devbox_shell {" (devbox)"} else {""}

    let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
    let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
    let path_segment = $"($path_color)($dir)(ansi blue)($devbox_shell_part)"

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}

def create_prompt [] {
    let upper_part = create_upper_part
    let lower_part = create_lower_part

    $"($upper_part)\n($lower_part)"
}

$env.PROMPT_COMMAND = {|| create_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| null}

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# # env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

$env.PATH = ($env.PATH | prepend '~/.cargo/bin')
$env.EDITOR = "hx"
