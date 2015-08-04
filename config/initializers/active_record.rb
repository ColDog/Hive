module CacheKeys
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
  end
end

ActiveRecord::Base.send(:include, CacheKeys)
