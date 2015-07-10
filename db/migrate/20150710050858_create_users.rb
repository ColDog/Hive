class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :name
      t.string      :email,         index: true
      t.string      :password_digest
      t.text        :tags,          array: true
      t.text        :about
      t.string      :avatar

      t.timestamps null: false
    end
  end
end
