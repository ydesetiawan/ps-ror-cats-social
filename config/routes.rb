# routes

Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    post 'user/register', to: 'users#register'
    post 'user/login', to: 'users#login'

    resources :cat, only: [:create, :update, :destroy, :index]
  end
end
