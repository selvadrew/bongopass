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

  resources :tickets do 
    resources :orders
  end
  
  resources :referrals do 
    resources :tickets do 
      resources :orders 
    end
  end


resources :events, only: [:index] do 
  member do 
    get 'sold'
  end
end

  root 'pages#home'
  get 'sales' => "orders#sales"
  get 'purchases' => "orders#purchases"
  get '/payout_method' => "users#paypal_payout"


  
 
end
