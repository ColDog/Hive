class RemoveAgreementsFromOrganization < ActiveRecord::Migration
  def change
    remove_column :organizations, :service_agreement, :string
  end
end
