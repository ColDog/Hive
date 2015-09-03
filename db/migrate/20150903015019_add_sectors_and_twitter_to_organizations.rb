class AddSectorsAndTwitterToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :sector, :string
    add_column :organizations, :twitter, :string
  end
end
