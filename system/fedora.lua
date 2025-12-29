local helpers = require("helpers")

tasks["check_is_fedora"] = {
    handler = function(system)
        local result = system:run_command("cat /etc/os-release")

        if string.find(result.stdout, "ID=fedora") then
            log.info("fedora system detected")

            return true
        else
            log.info("system is not fedora")

            return false
        end
    end,
    tags = {},
}

tasks["setup_fedora"] = {
    when = function()
        return tasks["check_is_fedora"].result == true
    end,
    handler = function(system)
        local is_fedora = tasks["check_is_fedora"].result

        if not is_fedora then
            return
        end

        local commands = {
            "sudo dnf update -y",
            "sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm",
            "sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y",
        }

        helpers.execute_commands(system, unpack(commands))
    end,
}
