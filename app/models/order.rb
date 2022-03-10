class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  has_many :products, through: :order_details
  enum status: {new_order: 0, accepted: 1, rejected: 2, canceled: 3, success: 4}

  validates :user_id, presence: true
  validates :order_address, presence: true

  delegate :name, :email, :phone, to: :user, prefix: :user
  scope :filter_by_date, (lambda do |start_date, end_date|
    where("created_at BETWEEN ? AND ?", start_date, end_date)
  end)
  scope :sort_by_total_desc, (lambda do
    joins(:order_details)
    .group("id")
    .order("sum(order_details.quantity) DESC")
  end)
  scope :sort_by_total_asc, (lambda do
    joins(:order_details)
    .group("id")
    .order("sum(order_details.quantity) ASC")
  end)
  scope :newest, ->{order created_at: :desc}
  scope :search_by_status, ->(status){where(status: status) if status}
  scope :success_order_with_pro_id, (lambda do |product_id|
    joins(:order_details)
    .where.not(status: 4)
    .where("order_details.product_id = ?", product_id)
  end)
end
