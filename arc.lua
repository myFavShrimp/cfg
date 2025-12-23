targets.systems["local-system"] = {
    type = "local"
}

require("system/fedora")

require("application/rust")
require("application/rust_tools")
require("application/flatpaks")
