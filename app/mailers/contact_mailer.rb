class ContactMailer < ActionMailer::Base
  def contact(val)
    @contact = val
    mail(from: %("#{val.name}" <#{val.email}>), to: ENV["SENDER_EMAIL"], subject: val.subject)
  end
end
