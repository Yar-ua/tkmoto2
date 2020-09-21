Rails.application.routes.draw do

  get 'stata_repairs/new'

  get 'stata_repairs/edit'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  resources :bikes do
  	resources :stata_fuels
    resources :stata_repairs
  end

  root to: 'home#start'

  match '/signup', 		to: 'users#new',	      via: [:get]
  match '/signin',		to: 'sessions#new',	    via: [:get]
  match '/signout',   to: 'sessions#destroy', via: [:delete]

  match 'home/start', 	to: 'home#start', 	  via: [:get]
  match 'home/about', 	to: 'home#about', 	  via: [:get]


end