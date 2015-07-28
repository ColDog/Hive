class AddOrganizationToSupplyLists < ActiveRecord::Migration
  def change
    add_reference :supply_lists, :organization, index: true, foreign_key: true
  end
end
