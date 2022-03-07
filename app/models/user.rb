class User < ApplicationRecord
  PROPERTIES = %i(name email phone password
       password_confirmation remember_me).freeze
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :lockable
  enum role: {user: 0, admin: 1}
  has_many :orders, dependent: :destroy
  scope :newest, ->{order created_at: :desc}
  scope :search_by_name,
        ->(name){where("LOWER(name) LIKE ?", "%#{name.downcase}%") if name}
end
