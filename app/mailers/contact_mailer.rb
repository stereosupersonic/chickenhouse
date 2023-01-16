class ContactMailer < ApplicationMailer
  def contact(val)
    @contact = val
    mail(from: %("#{val.name}" <#{val.email}>), to: ENV.fetch("SENDER_EMAIL", nil), subject: val.subject)
  end
end
