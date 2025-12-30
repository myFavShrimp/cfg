tasks["detect_os"] = {
    handler = function(system)
        local os_result = system:run_command("uname -s")

        if os_result.stdout:find("Linux") then
            return "linux"
        elseif os_result.stdout:find("Darwin") then
            return "macos"
        else
            return
        end
    end,
    important = true,
}

tasks["check_is_fedora"] = {
    handler = function(system)
        local result = system:run_command("cat /etc/os-release")

        if string.find(result.stdout, "ID=fedora") then
            log.info("fedora system detected")

            return true
        else
            log.info("system is not fedora")

            return false
        end
    end,
    important = true,
}
