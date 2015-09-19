class SendUser < ApplicationMailer
  def mail_create(data, email)
    @data = data
    to = email
    mail(:to => to, :subject => "Purchase of images")
  end
end
