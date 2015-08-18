# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/new_user
  def new_user
    pars = {
      'content' => "Hello persons name, \n\nWelcome to the HiVE! I've got you all registered and invoiced, and you are officially a member of the HiVE! Your contract would have been sent to you via EchoSign for you to sign and return. Please let me know if it did not arrive. \n\nI have attached a little bit of information about how to be a great member of the HiVE and about our perks program. Also attached are instructions for connecting to the printer. Your user id for the printer is __ and the password is __. Printing is $0.10 per page for black and $0.35 for colour, billed every second month. \n\nPlease let me know if you have any questions or concerns! Thank you for joining the HiVE.",
      'sign_in_link' => '1', 'supplies' => '1', 'account_type' => '1', 'attachments' => Attachment.pluck(:id)
    }
    tok = 'p34zeA5xA7OsANGV8KDrKA'
    UserMailer.new_user(User.first, tok, pars)
  end

end
