class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user.subject
  #
  def new_user(user, digest, mail)
    @user = user
    @digest = digest
    @message = mail['content']
    @supplies = @user.all_supplies if mail['supplies']
    mail['attachments'].each do |att|
      file = Attachment.find_by(id: att.to_i)
      if file and file.file.url
        attachments[file] = file.file.url
      end
    end
    @type = @user.account_type if mail['account_type']
    mail( to: @user.email, subject: 'New Account Created at Hive' )
  end
end
