module Tagging
  module Instance
    attr_accessor :tagging
    def tagging=(val)
      write_attribute(:tags, val.split(','))
    end
    def pretty_tags
      str = '' ; tags.each { |t| str += "#{t} "} ; str
    end
  end
  module ClassMethods
    def all_tags
      self.all.pluck(:tags).flatten.uniq
    end
  end
end