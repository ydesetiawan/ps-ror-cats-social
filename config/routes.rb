# routes

Rails.application.routes.draw do
  namespace :v1, defaults: { format: :json } do
    post 'user/register', to: 'users#register'
    post 'user/login', to: 'users#login'

    resources :cat, only: [:create, :update, :destroy, :index]

    post 'cat/match', to: 'cat_match#create'
    get 'cat/match', to: 'cat_match#index'
    post 'cat/match/approve', to: 'cat_match#approve'
    post 'cat/match/reject', to: 'cat_match#reject'
    delete 'cat/match/delete', to: 'cat_match#delete'
  end
end
