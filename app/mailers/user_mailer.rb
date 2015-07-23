class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.new_user.subject
  #
  def new_user(user, digest)
    @user = user
    @digest = digest
    mail to: @user.email, subject: 'New Account Created at Hive'
  end
end
