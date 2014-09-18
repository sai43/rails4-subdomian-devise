Sample::Application.routes.draw do
  
  require 'subdomain'

  #resources :users, :only => :show
  resources :roles
  devise_for :users

  root 'home#index'


constraints(Subdomain) do
  match '/' => 'profiles#show', :via => [:get]
end

match '/' => 'home#index', :constraints => { :subdomain => 'www' }, :via => [:get]
match '/' => 'profiles#show', :constraints => { :subdomain => /.+/ }, :via => [:get]


  #get "profiles/show"
  #get "home/index"
 
end
