# routes

Rails.application.routes.draw do
  namespace :v1,defaults: { format: :json } do
    post 'user/register', to: 'users#register'
    post 'user/login', to: 'users#login'
    post 'cat', to: 'cats#create_cat'
  end
end
