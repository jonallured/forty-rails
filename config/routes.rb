Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'sign-in', to: 'devise/sessions#new'
    get 'sign-out', to: 'devise/sessions#destroy'
    get 'sign-up', to: 'devise/registrations#new'
  end

  get :ping, to: 'ping#show'
  get :today, to: 'today#show'

  root to: redirect('/today')
end
