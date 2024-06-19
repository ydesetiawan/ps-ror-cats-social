Rails.application.routes.draw do


  namespace :v1 do
    post 'user/register', to: 'users#register'
  end
end
