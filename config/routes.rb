Rails.application.routes.draw do

  root to: 'bikes#index'

  resources :bikes do
  	resources :fuels, except: :show
    resources :repairs
    resources :oils, except: :show
    resource :bike_configs, except: :destroy
  end

  match 'about', to: 'home#about', via: [:get]


end