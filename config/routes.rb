ActionController::Routing::Routes.draw do |map|
  # RESTful authentication resources.
  map.resources :users
  map.resource :account, :controller => 'account'

  # Login/Logout/Signup/Activation routes.
  map.login '/login', :controller => 'account', :action => 'new'
  map.logout '/logout', :controller => 'account', :action => 'destroy'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'

  # The front page of the site.
  map.root :controller => 'home', :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
