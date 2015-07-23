class AddHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signup_digest, :string
  end
end
