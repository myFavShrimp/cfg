local helpers = require("helpers")

tasks["obtain_user"] = {
    handler = function (system)
        local id_command_result = system:run_command("id -un")

        if id_command_result.exit_code ~= 0 then
            error("`id` command returned and error: " .. id_command_result.stderr)
        end

        return helpers.trim_whitespace(id_command_result.stdout)
    end
}

tasks["install_docker"] = {
    when = function()
        return tasks["check_is_fedora"].result == true
            and tasks["obtain_user"].state == "success"
    end,
    handler = function(system)
        local user = tasks["obtain_user"].result

        local commands = {
            "sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo",
            "sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
            "sudo dnf group install development-tools -y",
            "sudo usermod -aG docker " .. user,
            "sudo systemctl enable --now docker",
        }

        helpers.execute_commands(system, unpack(commands))

        log.info("User `" .. user .. "` was added to group `docker`. Remember to log out.")
    end,
}

