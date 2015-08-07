class CreateUploadLogs < ActiveRecord::Migration
  def change
    create_table :upload_logs do |t|
      t.json    :log
      t.string  :key, index: true

      t.timestamps null: false
    end
  end
end
