ActionController::Routing::Routes.draw do |map|
  map.root :controller => "groups"
  
  map.resources :groups
  map.resources :categories
  map.resources :administrators
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
