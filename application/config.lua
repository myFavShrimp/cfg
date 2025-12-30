local helpers = require("helpers")

local link_config = {
    {
        os = { "linux", "macos" },
        destination = "~/.config",
        items = {
            { name = "helix", path = ".config/helix" },
            { name = "alacritty", path = ".config/alacritty" },
            { name = "zellij", path = ".config/zellij" }
        }
    },
    {
        os = { "linux", "macos" },
        destination = "~",
        items = {
            { name = ".gitconfig", path = "gitconfig" }
        }
    },
    {
        os = { "linux", "macos" },
        destination = "~/.config",
        items = {
            { name = "nushell", path = ".config/nushell" }
        }
    },
    {
        os = { "macos" },
        destination = "~/Library/Application Support/",
        items = {
            { name = "nushell", path = ".config/nushell" }
        }
    }
}

tasks["build_symlink_config"] = {
    when = function()
        return tasks["detect_os"].result ~= nil
    end,
    handler = function()
        local current_os = tasks["detect_os"].result

        local cfg_repo_path = helpers.trim_whitespace(host:run_command("pwd").stdout)

        local links = {}
        for _, link in ipairs(link_config) do
            for _, os in ipairs(link.os) do
                if os == current_os then
                    for _, item in ipairs(link.items) do
                        local source_path = cfg_repo_path .. "/" .. item.path
                        local dest_path = link.destination .. "/" .. item.name

                        table.insert(links, {
                            source = source_path,
                            destination = dest_path,
                        })
                    end
                end
            end
        end

        return links
    end,
}

tasks["symlink_configs"] = {
    handler = function(system)
        local symlink_config = tasks["build_symlink_config"].result

        local link_commands = {}
        for _, link in ipairs(symlink_config) do
            local symlink_cleanup_command = "rm -rf " .. link.destination
            local symlink_command = "ln -sf " .. link.source .. " " .. link.destination

            table.insert(link_commands, symlink_cleanup_command)
            table.insert(link_commands, symlink_command)
        end

        helpers.execute_commands(system, unpack(link_commands))
    end,
}
