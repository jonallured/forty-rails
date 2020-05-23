class User < ApplicationRecord
  devise :database_authenticatable, :recoverable,
         :registerable, :rememberable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :work_days, dependent: :destroy

  def active?
    subscriptions.active.any?
  end

  def comped?
    subscriptions.comped.any?
  end
end
