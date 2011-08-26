$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

Dir.glob(File.expand_path(File.dirname(__FILE__))+'/bad_ass_extensions/*').each do |extension|
  require extension
end

module BadAssExtensions
  VERSION = '0.2.1'
end



