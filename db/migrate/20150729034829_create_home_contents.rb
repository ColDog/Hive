class CreateHomeContents < ActiveRecord::Migration
  def change
    create_table :home_contents do |t|
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
