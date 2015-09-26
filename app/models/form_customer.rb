class FormCustomer
  include ActiveModel::Model
  include Virtus.model

  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :avatar, String
  attribute :shop_name, String

  validates_format_of    :email,    :with  => Devise.email_regexp
  validates_presence_of    :password
  validates_confirmation_of    :password
  validates :password, length: { minimum: 8 }
  validate :unicemail
  validates :avatar, presence: true
  validates :shop_name, presence: true

  def unicemail
    if User.where( :email => self.email).any?
      errors.add(:email, 'This email is already use')
    end
  end

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  private

  def persist!
    user = User.create!(email: email, role: 'customer', password: password, password_confirmation: password, avatar: avatar, shop_name: shop_name)
  end

end
