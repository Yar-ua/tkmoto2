Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  root to: 'bikes#index'

  resources :bikes do
  	resources :fuels, except: :edit
    resources :repairs, except: :edit
    resources :oils, except: :edit
    resource :bike_configs, except: [:edit, :destroy]
  end

  match 'about', to: 'home#about', via: [:get]
  match 'secure', to: 'home#secure', via: [:get]


end