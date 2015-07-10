class SupplyList < ActiveRecord::Base
  belongs_to :user
  belongs_to :supply
end
