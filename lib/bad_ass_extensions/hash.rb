class Hash

  def largest_key
    rows =[]
    keys.each_with_index do |f, i|
      rows << [f.to_s.length, i]
    end
    index = rows.sort_by{|x| x[0]}.last[1]
    keys[index]
  end
  
  def rowized
    max_key_length = largest_key.length
    keys.map do |key|
      "#{key.to_s.rjust(max_key_length)}: #{self[key]}\n"
    end
  end
  
end
