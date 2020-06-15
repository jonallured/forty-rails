class User < ApplicationRecord
  devise :confirmable, :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
  has_many :work_days, dependent: :destroy

  after_create :notify_admin

  def active?
    subscriptions.active.any?
  end

  def comped?
    subscriptions.comped.any?
  end

  private

  def notify_admin
    AdminMailer.with(user_id: id).new_user_email.deliver_later
  end
end
