class SendAdminError < ApplicationMailer
  default to: Proc.new { User.admins.pluck(:email) }

  def mail_create(data)
    @data = data
    mail(:subject => "Notification about errors")
  end
end
