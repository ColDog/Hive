class Admin < ActiveRecord::Base
  belongs_to :user, touch: true

  validates :user_id, presence: true, uniqueness: true

end
