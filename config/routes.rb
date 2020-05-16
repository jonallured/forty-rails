path_names = {
  confirmation: 'confirm',
  password: 'password',
  registration: 'registration',
  sign_in: 'sign-in',
  sign_out: 'sign-out',
  sign_up: 'sign-up'
}

devise_options = {
  path: '',
  path_names: path_names,
  sign_out_via: :get
}

Rails.application.routes.draw do
  devise_for :users, devise_options

  devise_scope :user do
    get 'forgot', to: 'devise/passwords#new', as: :forgot
    get 'sign-in', to: 'devise/sessions#new', as: :sign_in
    get 'sign-out', to: 'devise/sessions#destroy', as: :sign_out
    get 'sign-up', to: 'devise/registrations#new', as: :sign_up
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
