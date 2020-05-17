class UserUpgrade
  def self.process(user, stripe_source_id)
    new(user, stripe_source_id).process
  end

  def initialize(user, stripe_source_id)
    @user = user
    @stripe_source_id = stripe_source_id
  end

  def process
    create_stripe_customer
    update_user
    create_stripe_subscription
    subscribe_user
  end

  private

  def create_stripe_customer
    customer_attrs = {
      email: @user.email,
      metadata: { userId: @user.id },
      source: @stripe_source_id
    }

    @stripe_customer = Stripe::Customer.create(customer_attrs)
  end

  def update_user
    user_attrs = {
      stripe_customer_id: @stripe_customer['id']
    }

    @user.update!(user_attrs)
  end

  def create_stripe_subscription
    sub_attrs = {
      customer: @stripe_customer['id'],
      items: [
        { plan: Forty.config.stripe_plan_id }
      ]
    }

    @stripe_subscription = Stripe::Subscription.create(sub_attrs)
  end

  def subscribe_user
    today = Time.zone.today

    sub_attrs = {
      ends_on: today + 1.year,
      starts_on: today,
      stripe_subscription_id: @stripe_subscription['id']
    }

    @user.subscriptions.create(sub_attrs)
  end
end
