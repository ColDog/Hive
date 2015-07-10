class User < ActiveRecord::Base
  has_secure_password
  include AuthModels
  belongs_to :organization
end
