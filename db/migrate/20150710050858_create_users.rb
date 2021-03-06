class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :name
      t.string   :phone
      t.string   :account_type
      t.date     :inactive_on
      t.boolean  :current,        default: true
      t.text     :notes

      t.timestamps null: false
    end
  end
end
