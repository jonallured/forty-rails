class TodayController < ApplicationController
  before_action :authenticate_user!

  expose(:bootstrap) do
    {
      stripePublicKey: Forty.config.stripe_public_key
    }
  end
end
