Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :users, only: [:index]
    get '/users/exists', to: 'users#exists'
    resources :views, only: [:index, :create, :destroy]
    resources :login, only: [:create]
    get '/logout', to: 'login#destroy'
    resources :media
    resources :registration, only: [:create, :destroy]
    post '/registration/password/recover', to: 'registration#recover_password'
    post '/registration/password/reset', to: 'registration#reset_password'
    post '/registration/password/recover/key', to: 'registration#get_user_by_reset_key'

end
