module Enumerable
  def group_count
    self.group_by{|u| yield(u)}.inject({}){|hash, group| hash[group[0]]= group[1].length;hash }
  end
end