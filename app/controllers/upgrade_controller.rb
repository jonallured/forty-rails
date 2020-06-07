class UpgradeController < AuthenticatedController
  before_action :ensure_upgrade_feature
  expose(:props) do
    {
      email: current_user.email,
      stripePublicKey: Forty.config.stripe_public_key
    }
  end

  def show
    redirect_to root_path if current_user.active?
  end

  def create
    stripe_source_id = params[:stripe_source_id]
    UserUpgrade.process(current_user, stripe_source_id)
    render json: {}
  end

  private

  def ensure_upgrade_feature
    redirect_to root_path unless Feature.enabled?(Feature::UPGRADE)
  end
end
