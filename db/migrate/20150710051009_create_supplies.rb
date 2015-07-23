class CreateSupplies < ActiveRecord::Migration
  def change
    create_table :supplies do |t|
      t.string  :name
      t.integer :maximum
      t.text    :notes

      t.timestamps null: false
    end
  end
end
