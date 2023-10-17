# Add file to staging area by pattern
export def "git add pattern" [
  pattern: string # Pattern to match
] {
  let matches = (git ls-files --exclude-standard -mdo | rg $pattern | lines)
  print $matches

  let answer = (input "Add files to staging area? (y/n/o):")

  if $answer == "y" {
    git add $matches
    git status
  }
}

# Set the username and email of the local git config
export def "git user" [
  username: string 
  email: string
] {
  git config --local user.name $username
  git config --local user.email $email
}
