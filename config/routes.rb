Rails.application.routes.draw do
  
  resources :spanish_messages
  resources :histories
  resources :messages
  resources :users
  root 'users#index'
  
  devise_for :admins, :controllers => { :registrations => "registrations" }

  post 'user/reply' => 'users#reply'
end
