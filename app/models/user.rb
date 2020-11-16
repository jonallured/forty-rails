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

  def free?
    !active? && !comped?
  end

  def can_view?(year, number)
    return true unless free?

    today = Time.zone.today
    this_week_year = today.cwyear.to_s
    this_week_number = today.strftime('%V')

    last_week = today - 1.week
    last_week_year = last_week.cwyear.to_s
    last_week_number = last_week.strftime('%V')

    requesting_this_week = year == this_week_year && number == this_week_number
    requesting_last_week = year == last_week_year && number == last_week_number

    requesting_this_week || requesting_last_week
  end

  def as_json(_)
    {
      isFree: free?
    }
  end

  private

  def notify_admin
    AdminMailer.with(user_id: id).new_user_email.deliver_later
  end
end
