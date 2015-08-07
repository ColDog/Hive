class ApplicationMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)
  default from: "no-reply@hive.com"
  layout 'mailer'
end
