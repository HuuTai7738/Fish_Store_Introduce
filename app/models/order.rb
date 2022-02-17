class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  enum status: {new_order: 0, accepted: 1, rejected: 2, canceled: 3, success: 4}

  validates :user_id, presence: true
  validates :order_address, presence: true
  scope :newest, ->{order created_at: :desc}
end
