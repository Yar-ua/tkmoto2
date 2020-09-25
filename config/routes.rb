Rails.application.routes.draw do

  root to: 'bikes#index'

  resources :bikes do
  	resources :fuels, except: :show
    resources :repairs
  end

  match 'about', to: 'home#about', via: [:get]


end