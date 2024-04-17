export use ~/.config/nushell/config/commands/git.nu *
export use ~/.config/nushell/config/commands/files.nu *

export def swiftlint [] {
    let lint_result = (^swiftlint | lines | filter {|line| $line !~ 'Linting'})
     $lint_result | parse ((pwd) + "{file_name}:{line}:{character}: {level}: {message}")
}
