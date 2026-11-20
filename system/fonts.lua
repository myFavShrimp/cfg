local helpers = require("../helpers")

local user_fonts_directory = "~/.local/share/fonts"

task "install_fonts" {
    when = function()
        return task["detect_os"].result == "linux"
    end,
    handler = function(target_system)
        local repository_fonts_directory = arc.project_root_path .. "/fonts"

        helpers.execute_commands(target_system, {
            "mkdir -p " .. user_fonts_directory,
            "cp -r " .. repository_fonts_directory .. "/* " .. user_fonts_directory,
            "rm -rf " .. user_fonts_directory .. "/Hack/Windows",
            "fc-cache -v",
        })
    end,
}

return nil
