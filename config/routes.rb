Fg2app::Application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      match 'users/me'  => 'users#me', as: :me_api_path
      match 'me'        => 'users#me', as: :me_api_path
      resources :users
      resources :pages
      resources :tabs
      resources :layouts
      # nest some stugg
    end
  end

  resources :fbapps

  resources :tabs

  root :to => "dash#index"

  get 'dash' => "dash#index"

  resources :pages

  #devise_scope :user do
    #match 'users/sign_in' => 'dash#index', as: :new_user_session
    #match 'users/sign_up' => 'dash#index', as: :new_user_registration
    #match "users/:id"     => 'users#show', as: :user
  #end

  #resources :users

  devise_for :users,
    :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

    #:path => 'users',
    #:skip => [:sessions],

  match '*route', to: 'dash#index'

  #as :user do
    # sessions
    #post 'signin' => 'devise/sessions#create', :as => :user_session
    #match 'signin' => 'dash#index', :as => :new_user_session
    #match 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
      #:via => Devise.mappings[:user].sign_out_via
  #end
    

  #devise_scope "user" do
  #  get 'login' => 'users/auth/facebook', :as => :new_user_session
  #  post 'signin' => 'devise/sessions#create', :as => :user_session
  #  delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  #end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
