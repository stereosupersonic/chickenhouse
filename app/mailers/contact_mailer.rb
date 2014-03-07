class ContactMailer < ActionMailer::Base
  def contact(_contact)
    @contact   =_contact
    mail(:from => %["#{ _contact.name}" <#{_contact.email}>], :to => ENV['SENDER_EMAIL'], :subject => _contact.subject)
  end
end
