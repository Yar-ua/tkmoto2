Rails.application.routes.draw do

  root to: 'bikes#index'
  
  # get 'stata_repairs/new'
  # get 'stata_repairs/edit'

  resources :bikes do
  	resources :fuels, except: :show
    # resources :stata_repairs
  end

  match 'about', 	to: 'home#about', 	  via: [:get]


end