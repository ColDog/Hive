class CreateOrganizationMembers < ActiveRecord::Migration
  def change
    create_table :organization_members do |t|
      t.references :user,         index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true
      t.boolean :admin_contact,   default: false
      t.boolean :account_contact, default: false

      t.timestamps null: false
    end
  end
end
