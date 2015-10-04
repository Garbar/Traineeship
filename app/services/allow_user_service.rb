class AllowUserService
  def initialize(user)
    @user = user
  end
  def call
    raise ErrorMessages::EmailError unless allow_email?
    raise ErrorMessages::RoleError if @user.role ==  0
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
