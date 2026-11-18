local helpers = require("../helpers")

local flatpaks = {
    "com.github.tchx84.Flatseal",
    "com.mattjakeman.ExtensionManager",
    "io.dbeaver.DBeaverCommunity",
    "io.github.peazip.PeaZip",
    "net.werwolv.ImHex",
    "org.fedoraproject.MediaWriter",
    "org.gustavoperedo.FontDownloader",
    "org.mozilla.Thunderbird",
    "org.signal.Signal",
    "rest.insomnia.Insomnia",
    "com.nitrokey.nitrokey-app2",
}

task "install_flatpaks" {
    handler = function(target_system)
        local commands = {}

        for _, flatpak in flatpaks do
            table.insert(commands, "flatpak install --reinstall --noninteractive flathub " .. flatpak)
        end

        helpers.execute_commands(target_system, commands)
    end,
}

return nil
