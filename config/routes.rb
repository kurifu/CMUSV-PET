ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => 'users', :action => 'home'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'

  map.admin_home 'admin_home', :controller => 'users',
    :action => 'admin_home'
  
  map.transfer_project 'transfer_project', :controller => 'users', 
    :action => 'transfer_project'

  map.admin_projects 'admin_projects', :controller => 'users',
    :action => 'admin_projects'

  map.connect '/users/:project_id/:user_id/assign', :controller => 'users',
    :action => 'assign'

  map.change_password 'change_password', :controller => 'users',
    :action => 'change_password'

  map.update_password 'update_password', :controller => 'users',
    :action => 'update_password'

  map.connect '/projects/log_hours', :controller=>:projects, :action=>:log_hours

  

  map.connect '/projects/error', :controller=>'projects', :action=>'error'
  map.connect '/projects/overview', :controller=> 'projects', :action=> 'overview'
  map.connect '/deliverables/add_attachment', :controller=>'deliverables', :action=>'add_attachment'

  map.connect '/:project_id/deliverables/', :controller=>:deliverables, :action=>:index

  map.resources :projects
  map.resources :user_sessions
  map.resources :users
  map.resources :about_us
  map.resources :contact
  map.resources :help
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
