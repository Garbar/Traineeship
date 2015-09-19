class SendAdminError < ApplicationMailer
  default to: Proc.new { User.where(role: 2).pluck(:email) }

  def mail_create(data)
    @data = data
    mail(:subject => "Notification about errors")
  end
end
