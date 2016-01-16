module DataConverstions
  extend ActiveSupport::Concern

  #
  # instnace methods
  #

  def self.to_bool(x)
    return true   if x == true   || x =~ (/(true|t|yes|y|1)$/i)
    return false  if x == false  || x.blank? || x =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{x}\"")
  end

  def self.compute_fico_mean(fico_range)
    l, h = fico_range.split("-").map(&:to_i)
    return l if (h.nil? and l > 0)
    return h if (l.nil? and h > 0)
    return ((h + l)/2)
  end


  #
  # class methods
  #

  module ClassMethods
  end
end
