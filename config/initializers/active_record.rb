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
      CSV.foreach(csv.path, headers: true) do |row|
        Rails.logger.debug "    IMPORT CSV ATTRIBUTES- START: #{row.to_hash}"
        Rails.logger.debug "    IMPORT CSV ATTRIBUTES- SLICE: #{opts[:slice]}"
        Rails.logger.debug "    IMPORT CSV ATTRIBUTES- MERGE: #{opts[:merge]}"
        attrs = row.to_hash.slice(*opts[:slice]).merge(opts[:merge])
        if opts[:password]
          pass = SecureRandom.hex(10)
          attrs.merge(password: pass, password_confirmation: pass)
        end
        Rails.logger.debug "    IMPORT CSV ATTRIBUTES- END:   #{attrs}"
        begin
          obj = self.find_by(id: attrs['id'])
          if obj
            obj.update attrs
            result[:successes][:updated] << attrs
          else
            attrs['id'] = nil
            self.create! attrs
            result[:successes][:new] << attrs
          end
        rescue Exception => e
          result[:errors] << { name: attrs['name'], error: e.message }
        end
      end

      UploadLog.create(log: result, key: opts[:key])
    end

  end
end

ActiveRecord::Base.send(:include, Extensions)
