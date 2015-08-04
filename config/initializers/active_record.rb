module CacheKeys
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_key(params)
      route   = "#{params['controller']}/#{params['action']}/#{params['id']}"
      count   = self.count
      updated = self.maximum(:updated_at).try(:utc).try(:to_s, :number)
      "#{route}-#{count}-#{updated}"
    end
  end
end

ActiveRecord::Base.send(:include, CacheKeys)
