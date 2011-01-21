class Histogram
  def initialize(data, options={})
    
    if data.is_a?(Array)
      puts "Array"
      @hash = data.group_by{|x| x}.inject({}){|hash, val| hash[val[0]] = val[1].length;hash}
    elsif data.is_a?(Hash)  && data[data.keys.first].is_a?(Array)
      puts "Hash of Array"
      @hash = data.inject({}){|hash, val| hash[val[0]] = val[1].length;hash}
    elsif data.is_a?(Hash)  && data[data.keys.first].is_a?(Integer)
      puts "Hash of Integer"
      @hash = data
    elsif data.is_a?(Hash)  && data[data.keys.first].is_a?(String) && data[data.keys.first].to_i.is_a?(Integer)
      puts "Hash of Integer String"
      @hash = data.inject({}){|hash, val| hash[val[0]] = val[1].to_i;hash}
    else
      raise "Need to be throwing out an array of item, a hash where each val is an array or a hash where each val is an integer"
    end
    puts @hash.inspect
    
    @title = options[:title] || "Histogram by Jay"
    @hist_height = options[:height] || 100
    @total = @hash.inject(0){|sum, val| sum += val[1];sum}
    @sorted_keys = @hash.keys.sort
    @max_key_length = @sorted_keys.map{|x| x.to_s.length}.max
    @max_int_length = @hash.map{|k,v| v.to_s.length}.max
    @hash_modified = @hash.inject({}){|hash, val| hash[val[0]] = ((val[1].to_f/@total)*@hist_height);hash}
  end
  
  def pad_string(string, max_length)
    len = string.to_s.length
    pad = max_length - len
    string.to_s + (" " * pad)
  end
  
  def sorted_padded_keys(string_array)
    max_length = string_array.map{|x| x.length}.max
    new_arry = string_array.inject([]) do |arr, val|
      len = val.length
      pad = max_length - len
      arr << val + (" " * pad)
      arr
    end
    new_arry.sort
  end
  
  def draw(options={})
    draw_title(@title)
    value = options[:value] || nil
    percent = options[:percent] || nil
    
    @sorted_keys.each do |key|
      value = pad_string(@hash[key].to_s, @max_int_length) if value
      percent = clean_percent(@hash_modified[key]) if percent
      puts "#{pad_string(key, @max_key_length)}\t#{value}\t#{percent}\t#{'*' * (@hash_modified[key]+1)}"
    end
  end
  
  def clean_percent(value)
    int = value.to_i
    int = "%2d" % int # "%02d" if you want to pad with zeros
    prec = (value - int.to_i).to_s[2..5]
    "#{int}.#{prec}"
  end
  
  def draw_title(string, options={})
    pad_char = options[:pad_char] || '-'
    puts pad_char * (string.length + 6)
    puts "#{pad_char}#{pad_char} " + string + " #{pad_char}#{pad_char}"
    puts pad_char * (string.length + 6)
  end
end

## USAGE

# array = [1, 1, 3, 3, 3, 4,4, 4, 4,4, 4, 4,4,4, 4,4 ,4, 5,6,6,6, 6,6,6 ,67, 7, 78]
# Histogram.new(array).draw
# 
# hashy = {"Trial cancelation confirmation"=>"51", "Monitor system activated"=>"716", "No zendesk message"=>"3", "Zendesk message"=>"3", "Cancelation refund confirmation"=>"5", "Plan change confirmation"=>"1", "Subscription signup notification"=>"161", "Mobile report"=>"7", "Reset password"=>"28", "Cancelation confirmation"=>"11", "New member"=>"161"} 
# Histogram.new(hashy).draw
# hashy2 = {'aasdf' => 10, 'aaaaaaaaaeeb' => 50, 'c' => 100, 'd' => 20}
# Histogram.new(hashy2, :title => 'Big Testing Title').draw(:value => true, :percent => true)
