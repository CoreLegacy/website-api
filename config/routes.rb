Rails.application.routes.draw do
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
    resources :users, only: [:index]
    resources :views, only: [:index, :create, :destroy]
    resources :login, only: [:create, :destroy, :reset_password]
    resources :media
    resources :registration, only: [:create, :destroy]
    post '/registration/password/recover', to: 'registration#recover_password'
    post '/registration/password/reset', to: 'registration#reset_password'

end
