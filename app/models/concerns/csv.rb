module Csv
  extend ActiveSupport::Concern
  module Build
    def build_csv
      CSV.generate do |csv|
        names = self.column_names - ['encrypted_password']
        csv << names
        self.all.each do |record|
          hsh = record.attributes
          hsh['encrypted_password'] = nil if hsh['encrypted_password'].present?
          csv << hsh.values_at(*names)
        end
      end
    end
  end
  module Log
    def log_result(result, key)
      UploadLog.create(log: result, key: key)
    end
  end
end