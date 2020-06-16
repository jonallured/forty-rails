class AdminController < ApplicationController
  before_action :authenticate_admin!

  private

  def authenticate_admin!
    head :not_found unless current_user.id == 1
  end
end
