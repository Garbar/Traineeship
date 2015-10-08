class AllowUserService
  def initialize(user)
    @user = user
  end
  def call
    raise ErrorMessages::EmailError unless allow_email?
  end

  private
  def allow_email?
    if @user.email =~ /\.com$/
      return false
    else
      return true
    end
  end
end
