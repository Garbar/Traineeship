class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates_presence_of :title, :description, :image
  after_create :add_shop_name
  scope :pro, -> { where(:pro => true) }
  scope :unpro, -> { where(:pro => false) }
  def add_shop_name
    if self.user.role == 'customer'
      self.update_attributes(name_shop: self.user.shop_name)
    end
  end

end
