Rails.application.routes.draw do

  root to: 'bikes#index'
  
  get 'stata_repairs/new'
  get 'stata_repairs/edit'

  resources :bikes do
  	resources :stata_fuels
    resources :stata_repairs
  end

  match 'about', 	to: 'home#about', 	  via: [:get]


end