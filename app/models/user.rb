class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :registerable, :rememberable, :validatable

  has_many :work_days, dependent: :destroy
end
