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
    @supplies = []
    if mail['supplies']
      @user.all_supplies.each do |list|
        @supplies << { 'Type': list.supply.name, 'Name': list.name }
      end
    end

    @attach_urls = []
    mail['attachments'].each do |att|
      record = Attachment.find_by(id: att.to_i)
      @attach_urls << {name: record.filename, url: record.file.url}
    end
    @type = @user.account_type if mail['account_type']
    mail( to: @user.email, subject: 'New Account Created at Hive' )
  end
end
