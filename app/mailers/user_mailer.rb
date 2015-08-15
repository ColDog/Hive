class UserMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user.subject
  #
  def new_user(user, digest, mail)
    @user     = user
    @digest   = digest
    @message  = mail['content']

    # checks
    @include_link     = mail['sign_in_link']  == '1' ? true : false
    @include_supplies = mail['supplies']      == '1' ? true : false
    @include_type     = mail['account_type']  == '1' ? true : false

    @supplies = []
    if @include_supplies
      @user.all_supplies.each do |list|
        @supplies << { 'Type': list.supply.name, 'Name': list.name }
      end
    end

    @attach_urls = []
    if mail['attachments'].present?
      mail['attachments'].each do |att|
        record = Attachment.find_by(id: att.to_i)
        @attach_urls << {name: record.filename, url: record.file.url} if record
      end
    end

    @type = @user.account_type if mail['account_type'].present?
    mail( to: @user.email, subject: 'New Account Created at Hive' )
  end
end
