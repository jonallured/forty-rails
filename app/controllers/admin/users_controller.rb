module Admin
  class UsersController < AdminController
    expose(:users) { User.all.order(:id) }
  end
end
