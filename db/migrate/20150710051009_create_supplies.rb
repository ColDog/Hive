class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string :name
      t.string :type
      t.string :maximum
      t.text :notes

      t.timestamps null: false
    end
  end
end
