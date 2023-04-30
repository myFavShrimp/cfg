mkdir /usr/share/fonts/hack
ls fonts/Hack/ | where name !~ 'Windows' and name =~ '.ttf' | each {|input| cp $input.name /usr/share/fonts/hack }
