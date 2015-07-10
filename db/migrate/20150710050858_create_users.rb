class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.references :organization, index: true, foreign_key: true
      t.boolean :admin_contact
      t.boolean :account_contact

      t.timestamps null: false
    end
  end
end
