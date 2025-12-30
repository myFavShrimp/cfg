local helpers = require("helpers")

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
