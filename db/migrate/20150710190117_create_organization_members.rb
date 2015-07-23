class CreateOrganizationMembers < ActiveRecord::Migration
  def change
    create_table :organization_members do |t|
      t.references :user,         index: true, foreign_key: true
      t.references :organization, index: true, foreign_key: true
      t.boolean :admin_contact
      t.boolean :account_contact

      t.timestamps null: false
    end
  end
end
