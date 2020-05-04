Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get 'sign-in', to: 'devise/sessions#new'
    get 'sign-out', to: 'devise/sessions#destroy', as: :sign_out
    get 'sign-up', to: 'devise/registrations#new'
  end

  get :ping, to: 'ping#show'
  get :today, to: 'today#show'

  get 'pto', to: 'pto#index'
  get 'pto/:year', to: 'pto#show', as: :pto_report

  get 'work_weeks/:target', to: 'work_weeks#show', as: :work_week

  patch 'work_days/:id', to: 'work_days#update'

  get :account, to: 'account#show'

  root to: redirect('/today')
end
