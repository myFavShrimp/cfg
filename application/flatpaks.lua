local helpers = require("helpers")

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
}

tasks["install_flatpaks"] = {
    handler = function(system)
        local commands = {}

        for _, flatpak in ipairs(flatpaks) do
            local install_command = "flatpak install --reinstall --noninteractive flathub " .. flatpak

            table.insert(commands, install_command)
        end

        helpers.execute_commands(
            system,
            unpack(commands)
        )
    end,
}
