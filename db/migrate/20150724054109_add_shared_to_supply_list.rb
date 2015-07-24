class AddSharedToSupplyList < ActiveRecord::Migration
  def change
    add_column :supply_lists, :shared, :boolean
  end
end
