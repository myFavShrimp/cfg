local helpers = require("helpers")

local user_fonts_dir = "~/.local/share/fonts"

tasks["install_fonts"] = {
    handler = function(system)
        local current_os = tasks["detect_os"].result
        
        if current_os ~= "linux" then
            log.error("Not setting up fonts. System is not linux.")
            return
        end

        local cfg_repo_path = helpers.trim_whitespace(host:run_command("pwd").stdout)
        local repo_fonts_dir = cfg_repo_path .. "/fonts/"

        local commands = {
            "mkdir -p " .. user_fonts_dir,
            "cp -r " .. repo_fonts_dir .. "/* " .. user_fonts_dir,
            "rm -rf " .. user_fonts_dir .. "/Hack/Windows",
            "fc-cache -v",
        }

        helpers.execute_commands(system, unpack(commands))
    end,
    dependencies = { "detect_os" },
}
