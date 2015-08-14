class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.references  :organization, index: true, foreign_key: true
      t.string      :agreement
      t.date        :valid_until

      t.timestamps null: false
    end

    Organization.all.each do |org|
      Agreement.create!(organization_id: org.id, agreement: org.service_agreement)
    end

    remove_column :organizations, :service_agreement
  end
end
