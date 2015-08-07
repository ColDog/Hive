module Extensions
  extend ActiveSupport::Concern

  module ClassMethods

    def cache_key(params, opts = {})
      route   = "#{params['controller']}/#{params['action']}/#{params['id']}"
      search  = opts[:search] ? "s=#{params['search']}&c=#{params['category']}&a=#{params['current']}" : 'no-s'
      pages   = opts[:page] ? "p=#{params['page']}&pp=#{params['per_page']}" : ''
      count   = self.count
      updated = self.maximum(:updated_at).try(:utc).try(:to_s, :number)
      "#{route}-#{count}-#{updated}?#{search}#{pages}#{opts[:add]}"
    end

    def import_base(csv, opts = {})
      result = {errors: [], successes: { updated: [], new: [] }}
      tot = 0
      CSV.foreach(csv.path, headers: true) do |row|
        attrs = row.to_hash.slice(*opts[:slice], 'id').merge(opts[:merge])

        Rails.logger.debug "    IMPORT DATA: \n    Model: #{self.name}, \n    Attributes: #{attrs}, \n    Password: #{opts[:password]}"

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
        total_updated: result[:successes][:updated].count
      }

      UploadLog.create(log: result, key: opts[:key])
    end

  end
end

ActiveRecord::Base.send(:include, Extensions)
