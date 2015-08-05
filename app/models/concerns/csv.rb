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
  module User
    def import(csv)
      errors = {  }
      successes = []
      count = 0
      CSV.foreach(csv.path, headers: true) do |row|
        pass = SecureRandom.hex(10)
        hsh = row.to_hash.slice(
          'name', 'email', 'phone', 'account_type', 'inactive_on', 'current',
          'password', 'password_confirmation'
        ).merge(password: pass, password_confirmation: pass)
        begin
          User.create! hsh
          successes << hsh['email']
        rescue Exception => e
          if hsh['email']
            errors[ hsh['email'] ] = e.message
          else
            errors[ count ] = e.message
          end
        end
        count += 1
      end
      fin = { } ; fin[:errors] = errors ; fin[:successes] = successes
      return fin
    end
  end
  module Organization
    def import(csv)
      errors = {  }
      successes = []
      count = 0
      CSV.foreach(csv.path, headers: true) do |row|
        hsh = row.to_hash.slice(
          'name', 'description', 'signed_service_agreement', 'current',
          'inactive_on', 'address', 'city', 'province', 'postal'
        )
        begin
          Organization.create! hsh
          successes << hsh['name']
        rescue Exception => e
          if hsh['name']
            errors[ hsh['name'] ] = e.message
          else
            errors[ count ] = e.message
          end
        end
        count += 1
      end
      fin = { } ; fin[:errors] = errors ; fin[:successes] = successes
      return fin
    end
  end
  module SupplyList
    def build_csv(scope = :all, args = [])
      CSV.generate do |csv|
        csv << ['id', 'name', 'supply name', 'owner name', 'type']
        self.send(scope, *args).each do |record|
          csv << [record.id, record.name, record.supply.name, record.owner ? record.owner.name : nil, record.type]
        end
      end
    end
    def import(csv, supply_id)
      errors = {  }
      successes = []
      count = 0
      CSV.foreach(csv.path, headers: true) do |row|
        hsh = row.to_hash.slice('name', 'notes', 'id').merge('supply_id' => supply_id.to_i)
        begin
          sup = SupplyList.find_by(id: hsh['id'])
          if sup
            sup.update! hsh
          else
            hsh['id'] = nil
            SupplyList.create! hsh
          end
          successes << hsh['name']
        rescue Exception => e
          if hsh['name']
            errors[ hsh['name'] ] = e.message
          else
            errors[ count ] = e.message
          end
        end
        count += 1
      end
      fin = { } ; fin[:errors] = errors ; fin[:successes] = successes
      return fin
    end
  end
end