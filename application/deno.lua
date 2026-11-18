local global_packages = {
    "npm:intelephense",
    "npm:bash-language-server",
}

local function run_install_command(target_system: System, command: string)
    local install_result = target_system:run_command(command)

    if install_result.exit_code ~= 0 then
        log.error(install_result.stderr)
        error("installation returned an error: " .. install_result.stderr)
    end
end

task "install_deno" {
    handler = function(target_system)
        run_install_command(target_system, "curl -fsSL https://deno.land/install.sh | sh")
    end,
}

task "install_global_deno_packages" {
    handler = function(target_system)
        for _, global_package in global_packages do
            run_install_command(target_system, "deno install -Af -g " .. global_package)
        end
    end,
}

return nil
