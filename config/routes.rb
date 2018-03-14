Rails.application.routes.draw do

  devise_for :admins


  devise_for :users, 
  			 :path => '', 
  			 :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile', :sign_up => 'registration'},
  			 :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
  			 				  :registrations => 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]
  resources :photos, only: [:create, :destroy]
  resources :speakers, only: [:create, :destroy]
  resources :sponsors, only: [:create, :destroy]
  resources :images, only: [:create, :destroy]


  
  
  resources :events do 
    resources :tickets
  end

  resources :tickets, :path => 'new-pass' do 
    resources :orders
  end
  
  resources :referrals, :path => 'invitation' do 
    resources :tickets do 
      resources :orders 
    end
  end


resources :events, except: [:edit] do 
  member do 
    get 'sold'
  end
end

resources :referrals,:path => 'invitation' do 
  member do 
    get 'mypass'
  end
end


root to: 'pages#home'


  get 'host' => 'pages#home'  
  get 'sales' => "orders#sales"
  get 'purchases' => "orders#purchases"
  get '/payout_method' => "users#paypal_payout"
  get 'sindu' => 'supports#sindu'

  #get 'support' => "pages#support"


  get 'join' => "joins#new"
  get 'support' => "supports#new"
  resources "joins", only: [:new, :create]
  resources "supports", only: [:new, :create]

require 'sidekiq/web'
mount Sidekiq::Web => "/sidekiq"

  
 
end
