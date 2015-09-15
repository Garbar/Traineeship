class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  validates_presence_of :title, :description, :image
end
