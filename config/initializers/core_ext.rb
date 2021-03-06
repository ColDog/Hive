module ToTable
  def to_table(remove = [])
    return '<p>None</p>' if self.count == 0 or !self
    recs = self.as_json
    html = []
    head = recs[0].keys - remove
    html << '<table class="table">'
    html << '<thead><tr>'
    head.each { |item| html << "<th>#{item}</th>" }
    html << '</thead></tr>'
    recs.each do |rec|
      html << '<tr>'
      rec.values_at(*head).each { |item| html << "<td>#{item}</td>"  }
      html << '</tr>'
    end
    html << '</table>'
    html.join('')
  end
end

module CacheKey
  def cache_key
    "#{self.name}/#{self.maximum(:updated_at).to_i}C#{self.count}--"
  end
end

module CsvExtension
  module ClassMethods

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

    def import_base(csv, opts = {})
      result = {errors: [], successes: { updated: [], new: [] }}
      tot = 0
      CSV.foreach(csv.path, headers: true) do |row|
        attrs = row.to_hash.slice(*opts[:slice], 'id').merge(opts[:merge])

        begin
          obj = self.find_by(id: attrs['id'].to_i)
          if obj
            obj.update attrs
            result[:successes][:updated] << attrs
          else
            attrs['id'] = nil
            if opts[:password]
              pass = SecureRandom.hex(10)
              attrs = attrs.merge(password: pass, password_confirmation: pass)
            end
            self.create! attrs
            attrs.delete(:password)
            attrs.delete(:password_confirmation)
            result[:successes][:new] << attrs
          end
        rescue Exception => e
          result[:errors] << { name: attrs['name'], error: e.message }
        end

        tot += 1
      end

      result[:info] = {
        name: self.name, total_records: tot,
        total_new: result[:successes][:new].count,
        total_updated: result[:successes][:updated].count,
        total_errors: result[:errors].count
      }

      UploadLog.create(log: result, key: opts[:key])
    end
  end
end

class String
  def to_html
    GitHub::Markdown.render_gfm(self) if self
  end
end

class Array
  include ToTable
end

class NilClass
  def to_html
    nil
  end
  def to_table
    nil
  end
end

module Extensions
  extend ActiveSupport::Concern
  include ToTable
  module ClassMethods
    include CacheKey
    include CsvExtension::ClassMethods
  end
end

ActiveRecord::Base.send(:include, Extensions)