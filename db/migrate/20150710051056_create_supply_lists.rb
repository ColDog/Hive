class CreateSupplyLists < ActiveRecord::Migration
  def change
    create_table :supply_lists do |t|
      t.references  :user,    index: true, foreign_key: true
      t.references  :supply,  index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
