class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #   :recoverable, :rememberable, :trackable, :validatable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable
  has_many :products

  # validates :password, presence: true, confirmation: true, length: { minimum: 8 }
  # validates_uniqueness_of    :email,     :case_sensitive => false, :allow_blank => true, :if => :email_changed?
  # validates_format_of    :email,    :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  # validates_presence_of    :password, :on=>:create
  # validates_confirmation_of    :password, :on=>:create
  # validates :password, length: { minimum: 6 }, if: "role == 'user'"

  # with_options if: :is_admin? do |admin|
  #   admin.validates :password, length: { minimum: 10 }
  #   admin.validates :name, presence: true
  #   admin.validates :surname, presence: true
  #   admin.validates :avatar, presence: true
  #   admin.validates :passport, presence: true
  #   admin.validates :date_birth, presence: true
  # end

  # with_options if: :is_customer? do |admin|
  #   admin.validates :password, length: { minimum: 8 }
  #   admin.validates :avatar, presence: true
  #   admin.validates :shop_name, presence: true
  # end

  def is_admin?
    role == "admin"
  end

  def is_customer?
    role == "customer"
  end

  def allow_email?
    if self.email =~ /\.com$/
      return false
    else
      return true
    end
  end
  enum role: [:user, :customer, :admin]
  mount_uploader :avatar, ImageUploader
  mount_uploader :passport, ImageUploader

  def allow_product?
    if self.role ==  'user'
      return false
    else
      return true
    end
  end
end
