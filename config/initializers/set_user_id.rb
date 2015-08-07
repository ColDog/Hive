if ActiveRecord::Base.connection.table_exists? 'supplies'
  DESK_ID = Supply.where('name ILIKE ?', '%desk%').pluck(:id)
else
  DESK_ID = []
end

EMAIL_DEFAULT = "Welcome to the HiVE! \nI've got you all registered and invoiced, and you are officially a member of the HiVE! \nYour contract would have been sent to you via EchoSign for you to sign and return. Please let me know if it did not arrive. \nI have attached a little bit of information about how to be a great member of the HiVE and about our perks program. \nAlso attached are instructions for connecting to the printer. Your user id for the printer is  and the password is . Printing is $0.10 per page for black and $0.35 for colour, billed every second month. \nPlease let me know if you have any questions or concerns! Thank you for joining the HiVE."
