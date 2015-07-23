class Organization < ActiveRecord::Base
  has_many :organization_members
  has_many :supply_lists, through: :users
  has_many :users, through: :organization_members

  def tags=(val)
    write_attribute(:tags, val.split(',') )
  end

  def pretty_tags
    str = '' ; tags.map { |t| str += "#{t} "  } ; str
  end

  def self.select_tags
    tags = []
    Organization.pluck(:tags).each do |ary|
      ary.each { |t| tags << t }
    end
    if tags
      out = []
      tags.uniq.each do |tag|
        out << { id: tag, text: tag }
      end
      out.to_json
    end
  end

end
