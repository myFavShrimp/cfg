ls fonts/Hack/ | where name !~ 'Windows' and name =~ '.ttf' | each {|input| cp $input.name ~/.local/share/fonts }
