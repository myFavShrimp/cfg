tasks["install_deno"] = {
    handler = function (system)
        local install_result = system:run_command("curl -fsSL https://deno.land/install.sh | sh")

        if install_result.exit_code ~= 0 then
            log.error(install_result.stderr)
            error("installation returned an error: " .. install_result.stderr)
        end
    end
}

tasks["install_intelephense"] = {
    when = function ()
        return tasks["install_deno"].state == "success"
    end,
    handler = function (system)
        local install_result = system:run_command("deno install -Af -g npm:intelephense")

        if install_result.exit_code ~= 0 then
            log.error(install_result.stderr)
            error("installation returned an error: " .. install_result.stderr)
        end
    end
}
