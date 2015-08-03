class RemoveMaximumFromSupplies < ActiveRecord::Migration
  def change
    remove_column :supplies, :maximum
  end
end
