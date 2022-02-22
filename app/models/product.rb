class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :orders, through: :order_details
  enum status: {activated: 0, deactivated: 1}
  scope :activated_products, ->{where status: 0}
  scope :feature_products, ->{order(created_at: :desc).limit(6)}
  scope :newest, ->{order created_at: :desc}
  scope :search_by_name,
        ->(name){where("LOWER(name) LIKE ?", "%#{name.downcase}%") if name}
  delegate :name, to: :category, prefix: :category
  validates :name,
            presence: true,
            length: {
              maximum: Settings.str_length
            }
  validates :description, presence: true
  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: Settings.zero
            }
  validates :price, presence: true,
            numericality: {
              greater_than: Settings.zero
            }
  validates :unit, presence: true
end
