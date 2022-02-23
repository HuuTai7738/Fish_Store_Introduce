class User < ApplicationRecord
  enum role: {user: 0, admin: 1}
  has_many :orders, dependent: :destroy
  has_secure_password
  scope :newest, ->{order created_at: :desc}
  scope :search_by_name,
        ->(name){where("LOWER(name) LIKE ?", "%#{name.downcase}%") if name}
end
