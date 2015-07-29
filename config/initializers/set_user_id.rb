if ActiveRecord::Base.connection.table_exists? 'supplies'
  desk = Supply.find_by(name: 'Desk')
  if desk
    DESK_ID = desk.id
  else
    DESK_ID = nil
  end
end