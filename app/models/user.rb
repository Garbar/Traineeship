class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable
  has_many :products
  def is_admin?
    role == "admin"
  end
  def is_customer?
    role == "customer"
  end

  enum role: [:user, :customer, :admin]
  scope :admins, -> { where(role: 2) }
  mount_uploader :avatar, ImageUploader
  mount_uploader :passport, ImageUploader

end
