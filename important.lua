task "detect_os" {
    important = true,
    handler = function(target_system)
        if target_system:run_command('test "$(uname -s)" = Linux').exit_code == 0 then
            return "linux"
        end

        if target_system:run_command('test "$(uname -s)" = Darwin').exit_code == 0 then
            return "macos"
        end

        return nil
    end,
}

task "check_is_devbox" {
    important = true,
    handler = function()
        local is_devbox = env.get("DEVBOX") == "1"

        if is_devbox then
            log.info("devbox detected")
        end

        return is_devbox
    end,
}

task "check_is_macos" {
    important = true,
    handler = function(target_system)
        local is_macos = target_system:run_command('test "$(uname -s)" = Darwin').exit_code == 0

        if is_macos then
            log.info("macos system detected")
        else
            log.info("system is not macos")
        end

        return is_macos
    end,
}

task "check_is_fedora" {
    important = true,
    handler = function(target_system)
        local is_fedora = target_system:run_command("grep -qx 'ID=fedora' /etc/os-release").exit_code == 0

        if is_fedora then
            log.info("fedora system detected")
        else
            log.info("system is not fedora")
        end

        return is_fedora
    end,
}

return nil
