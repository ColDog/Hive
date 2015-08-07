if ActiveRecord::Base.connection.table_exists? 'supplies'
  DESK_ID = Supply.where('name ILIKE ?', '%desk%').pluck(:id)
else
  DESK_ID = []
end
