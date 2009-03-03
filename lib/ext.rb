module Inflections
  def constantize
    Object.const_get camelize
  end

  def camelize
    to_s.split("_").map{|w| w.capitalize}.join
  end
end

[String, Symbol].each do |cl| 
  cl.class_eval { include Inflections }
end
