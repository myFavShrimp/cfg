local helpers = require("../helpers")

task "install_docker" {
    when = function()
        return task["check_is_fedora"].result == true
    end,
    handler = function(target_system)
        helpers.execute_commands(target_system, {
            "sudo dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo",
            "sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
            "sudo dnf group install development-tools -y",
            "sudo usermod -aG docker \"$(id -un)\"",
            "sudo systemctl enable --now docker",
        })

        log.info("Current user was added to group `docker`. Remember to log out.")
    end,
}

return nil
