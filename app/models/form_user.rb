class FormUser
  include ActiveModel::Model
  include Virtus.model

  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String

  # validates_uniqueness_of    :email,     :case_sensitive => false
  validates_format_of    :email,    :with  => Devise.email_regexp
  validates_presence_of    :password
  validates_confirmation_of    :password
  validates :password, length: { minimum: 6 }
  validate :unicemail

  def unicemail
    if User.where( :email => self.email).any?
      errors.add(:email, 'This email is already use')
    end
  end

  def save
    if valid?
      persist!
    else
      false
    end
  end

  private

  def persist!
    @user = User.create!(email: email, role: 'user', password: password, password_confirmation: password)
    @user.id
  end

end
