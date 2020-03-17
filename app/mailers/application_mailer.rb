class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets[:production][:GMAIL_USER_NAME]
  layout 'mailer'
end
