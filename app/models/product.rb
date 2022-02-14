class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  enum status: {activated: 0, deactivated: 1}
  scope :activated_products, ->{where status: 0}
  scope :feature_products, ->{order(created_at: :desc).limit(6)}
end
