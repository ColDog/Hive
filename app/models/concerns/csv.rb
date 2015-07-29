module Csv
  extend ActiveSupport::Concern

  def build_csv
    CSV.generate do |csv|
      csv << self.column_names
      self.all.each do |record|
        csv << record.attributes.values_at(*self.column_names)
      end
    end
  end
end