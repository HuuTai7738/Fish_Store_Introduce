class User < ApplicationRecord
  enum role: {user: 0, admin: 1}
  has_many :orders, dependent: :destroy
  has_secure_password
end
