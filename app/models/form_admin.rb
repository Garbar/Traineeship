class FormAdmin
  include ActiveModel::Model
  include Virtus.model

  attribute :email, String
  attribute :password, String
  attribute :password_confirmation, String
  attribute :avatar, String
  attribute :surname, String
  attribute :name, String
  attribute :passport, String
  attribute :date_birth, DateTime

  validates_format_of    :email,    :with  => Devise.email_regexp
  validates_presence_of    :password
  validates_confirmation_of    :password
  validates :password, length: { minimum: 10 }
  validate :unicemail
  validates :avatar, presence: true
  validates :name, presence: true
  validates :surname, presence: true
  validates :passport, presence: true
  validates :date_birth, presence: true

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
    @user = User.create!(email: email, role: 'customer', password: password, password_confirmation: password, avatar: avatar,
                         name: name, surname: surname, passport: passport, date_birth: date_birth)
    @user.id
  end

end
