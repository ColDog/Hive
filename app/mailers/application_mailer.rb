class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@hive.com"
  layout 'mailer'
end
