class FeedbackMailer < ApplicationMailer
  default from: ENV['SMTP_USERNAME']
  default to: ENV['ADMIN_EMAIL']

  def new_feedback_email
    @feedback = params[:feedback]
    mail(subject: 'new feedback')
  end
end
