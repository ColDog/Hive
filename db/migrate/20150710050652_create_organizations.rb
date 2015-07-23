class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string  :name
      t.string  :description
      t.string  :avatar
      t.string  :service_agreement
      t.boolean :current
      t.date    :inactive_on

      t.string  :address
      t.string  :city
      t.string  :province

      t.text    :tags, array: true, default: []

      t.timestamps null: false
    end
  end
end
