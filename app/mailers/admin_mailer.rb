class AdminMailer < ApplicationMailer
  default to: Forty.config.admin_email

  def new_user_email
    @user = User.find params[:user_id]
    mail(subject: 'New User Sign Up!')
  end
end
