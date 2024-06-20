# Search files by name and replace matching part
export def "files rename" [
  matching: string # What to search for in file names
  to: string # What the matching part of the file name should be replaced with
] {
  let matches = (fd --full-path $matching | lines | input list --multi "Pick files to rename")

  $matches | par-each {|line| $line | str replace $matching $to | mv $line $in}
}

# Search files by name and delete them
export def "files remove" [
  pattern: string # File name pattern to match
] {
  let matches = (fd $pattern | lines | input list --multi "Pick files to remove")

  $matches | par-each {|line| rm $line}
}
