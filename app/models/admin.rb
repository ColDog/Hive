class Admin < ActiveRecord::Base
  has_secure_password
  include AuthModels
end
