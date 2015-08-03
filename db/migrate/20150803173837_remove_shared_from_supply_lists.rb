class RemoveSharedFromSupplyLists < ActiveRecord::Migration
  def change
    remove_column :supply_lists, :shared
  end
end
