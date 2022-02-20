class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  enum status: {new_order: 0, accepted: 1, rejected: 2, canceled: 3, success: 4}

  validates :user_id, presence: true
  validates :order_address, presence: true
  scope :newest, ->{order created_at: :desc}
  scope :success_order_with_pro_id, (lambda do |product_id|
    joins(:order_details)
    .where.not(status: 4)
    .where("order_details.product_id = ?", product_id)
  end)
end
