class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  ADMIN = 0
  TRAVELLER = 1

  has_many :flights

  enum role: { admin: ADMIN, traveller: TRAVELLER }
end
