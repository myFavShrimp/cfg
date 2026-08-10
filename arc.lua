targets.systems["local"] = {
    type = "local"
}

require("important")

require("system/fedora")

require("application/dnf")
require("application/brew")
require("application/config")
require("application/rust")
require("application/rust_tools")
require("application/flatpaks")
require("application/docker")
require("application/deno")
require("application/node")

require("system/fonts")
