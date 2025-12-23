targets.systems["local-system"] = {
    type = "local"
}

require("system/fedora")

require("application/dnf")
require("application/config")
require("application/rust")
require("application/rust_tools")
require("application/flatpaks")

require("system/fonts")
