local helpers = require("../helpers")

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
        os = { "linux" },
        destination = "~/.config/alacritty",
        items = {
            { name = "terminal.toml", path = ".config/alacritty/terminal-linux.toml" },
            { name = "font-size.toml", path = ".config/alacritty/font-size-linux.toml" }
        }
    },
    {
        os = { "macos" },
        destination = "~/.config/alacritty",
        items = {
            { name = "terminal.toml", path = ".config/alacritty/terminal-macos.toml" },
            { name = "font-size.toml", path = ".config/alacritty/font-size-macos.toml" }
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
        destination = "~/Library/Application\\ Support",
        items = {
            { name = "nushell", path = ".config/nushell" }
        }
    },
    {
        os = { "linux", "macos" },
        destination = "~/.claude",
        items = {
            { name = "CLAUDE.md", path = ".claude/CLAUDE.md" },
            { name = "settings.json", path = ".claude/settings.json" },
            { name = "notes", path = ".claude/notes" },
            { name = "skills", path = ".claude/skills" }
        }
    },
    {
        os = { "linux" },
        destination = "~/.claude",
        items = {
            { name = "os.md", path = ".claude/os-linux.md" }
        }
    },
    {
        os = { "macos" },
        destination = "~/.claude",
        items = {
            { name = "os.md", path = ".claude/os-macos.md" }
        }
    }
}

task "build_symlink_config" {
    when = function()
        return task["detect_os"].result ~= nil
    end,
    handler = function()
        local current_os = task["detect_os"].result

        local links = {}
        for _, link in link_config do
            if table.find(link.os, current_os) then
                for _, link_item in link.items do
                    table.insert(links, {
                        source = arc.project_root_path .. "/" .. link_item.path,
                        destination = link.destination .. "/" .. link_item.name,
                    })
                end
            end
        end

        return links
    end,
}

task "symlink_configs" {
    when = function()
        return task["build_symlink_config"].state == "success"
    end,
    handler = function(target_system)
        local link_commands = {}
        for _, link in task["build_symlink_config"].result do
            table.insert(link_commands, "rm -rf " .. link.destination)
            table.insert(link_commands, "ln -sf " .. link.source .. " " .. link.destination)
        end

        helpers.execute_commands(target_system, link_commands)
    end,
}

return nil
