local helpers = require("../helpers")

task "setup_fedora" {
    when = function()
        return task["check_is_fedora"].result == true
    end,
    handler = function(target_system)
        helpers.execute_commands(target_system, {
            "sudo dnf update -y",
            "sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm",
            "sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y",
        })
    end,
}

return nil
