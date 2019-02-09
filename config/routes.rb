Rails.application.routes.draw do
  devise_for :users
  get :ping, to: 'ping#show'
end
