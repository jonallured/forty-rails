# Preview emails at http://localhost:4040/rails/mailers/admin

class AdminPreview < ActionMailer::Preview
  def new_user_email
    user = User.first
    AdminMailer.with(user_id: user.id).new_user_email
  end
end
