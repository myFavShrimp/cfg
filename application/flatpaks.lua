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
        helpers.execute_commands(
            system,
            "flatpak install --reinstall --noninteractive flathub " .. table.concat(flatpaks, " ")
        )
    end,
}
