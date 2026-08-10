tasks["install_deno"] = {
    handler = function (system)
        local install_result = system:run_command("curl -fsSL https://deno.land/install.sh | sh")

        if install_result.exit_code ~= 0 then
            log.error(install_result.stderr)
            error("installation returned an error: " .. install_result.stderr)
        end
    end
}

local global_packages = {
    "npm:intelephense",
    "npm:bash-language-server",
}

tasks["install_global_deno_packages"] = {
    handler = function (system)
        for _, global_package in ipairs(global_packages) do
            local install_result = system:run_command("deno install -Af -g " .. global_package)

            if install_result.exit_code ~= 0 then
                log.error(install_result.stderr)
                error("installation returned an error: " .. install_result.stderr)
            end
        end
    end
}
