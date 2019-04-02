# frozen_string_literal: true

# Class for common mailer actions
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
