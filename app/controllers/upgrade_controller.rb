class UpgradeController < AuthenticatedController
  expose(:props) do
    {
      email: current_user.email,
      stripePublicKey: Forty.config.stripe_public_key
    }
  end

  def create
    stripe_source_id = params[:stripe_source_id]
    UserUpgrade.process(current_user, stripe_source_id)
    render json: {}
  end
end
