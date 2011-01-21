class Object
  def fputs(string)
    # move cursor to beginning of line
    cr = "\r"           

    # ANSI escape code to clear line from cursor to end of line
    # "\e" is an alternative to "\033"
    # cf. http://en.wikipedia.org/wiki/ANSI_escape_code

    clear = "\e[0K"     

    # reset lines
    reset = cr + clear
    print "#{reset}#{string}"
    $stdout.flush
    
  end
end
