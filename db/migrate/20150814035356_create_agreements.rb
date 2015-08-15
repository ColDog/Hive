class CreateAgreements < ActiveRecord::Migration
  def change
    create_table :agreements do |t|
      t.references  :organization, index: true, foreign_key: true
      t.string      :agreement
      t.string      :name
      t.date        :valid_until

      t.timestamps null: false
    end
  end
end
