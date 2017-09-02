Rails.application.routes.draw do

  devise_for :users, 
  			 :path => '', 
  			 :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
  			 :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
  			 				  :registrations => 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show]
  resources :photos
  resources :events do 
    resources :orders
  end

  root 'pages#home'
  get 'sales' => "orders#sales"
  get 'purchases' => "orders#purchases"

 
 
end
