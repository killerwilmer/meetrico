Metrocubico::Application.routes.draw do

  resources :item_categories

  resources :contact_messages

  resources :categories

  resources :activities do
    member do
      get :list
      get :booking
      get :query
      
    end
    collection do
      get :list
      get :booking
      get :query
    end

    resources :reservations, :controller => :activity_reservations do
      resources :tickets do
      end
    end
  end

  resources :images

  resources :states

  resources :orders 
  resources :carts do
    collection do
      get :tickets
    end
  end
  resources :products
  resources :line_items

  resources :configurations

  #match '/admins/list' => 'admins#list'
  devise_for :users
  #devise_for :carts
  #  devise_scope :admins do
  #    get :/admins' => "admins#prueba"
  #  end

  devise_for :admins
  #  devise_for :admins do
  #    get :/admins' => "admins#prueba"
  #  end

  #  devise_for :admins, :controllers => {:sessions => 'devise/sessions'}, :skip => [:sessions] do
  #    get :/admins' => 'admins#prueba', :as => :new_admin_session
  #    post 'signin' => 'admins#index', :as => :admin_session
  #    get :signout' => 'admins#index', :as => :destroy_admin_session
  #  end


  #match "/coworking_spaces/list" => "coworking_spaces#list"


  resources :users do
    member do
      get :list_owners
      get :search_by_name
      get :set_profile
    end

    collection do
      get :list_owners
      get :search_by_name
      get :set_profile
    end    
  end
  #  resources :admins
  resources :admins
  resources :authentications
  #  resources :authentications do
  #    member do
  #      post 'sign_in_lapapaya'
  #      get :sign_in_lapapaya'
  #    end
  #
  #    collection do
  #      post 'sign_in_lapapaya'
  #      get :sign_in_lapapaya'
  #    end
  #  end

  resources :subscription_requests
  resources :tables do
    member do
      get :validate_reservation_datetime
    end

    collection do
      get :validate_reservation_datetime
    end
  end
  
  resources :reservations do    
    collection do
      get :list
      get :reset
      get :aprove
      get :payment
      get :paylink
      get :liberate
      get :actives
    end
    
    
  end
  
  resources :coworking_spaces do
    member do
      get :list
      get :gallery
      get :validate_reservation_datetime
      get :search_by_name
      get :query
    end

    collection do
      get :list
      get :gallery
      get :validate_reservation_datetime
      get :search_by_name
      get :query
    end

    resources :item_categories do
      member do
        get :list
        #get :by_coworking_space
      end

      collection do
        get :list
        #get :by_coworking_space
      end
      resources :tables do        
      end
    end
  end

  get '/promociones' => 'item_categories#list', as: 'promotions'

  resources :tables do
    member do
      post :by_item_category
    end

    collection do
      post :by_item_category
    end
  end
  
  resources :item_categories do
    member do
      post :by_coworking_space
    end

    collection do
      post :by_coworking_space
    end
    
  end


  match '/auth/:provider/callback' => 'authentications#create'

  match '/addtonewsletter' => 'welcome#addtonewsletter', :as => :addtonewsletter
  match '/about' => 'welcome#about', :as => :about
  match '/admins' => 'admins#index', :as => :admins
  match '/owners' => 'users#owner_home', :as => :owners
  match '/sharing' => 'welcome#became_owner', :as => :sharing
  match '/faq' => 'welcome#faq', :as => :faq
  match '/us' => 'welcome#us', :as => :us
  match '/prensa' => 'welcome#prensa', :as => :prensa
  match '/testimonios' => 'welcome#testimonios', :as => :testimonios
  match '/ciudad_digital' => 'welcome#ciudad_digital', :as => :ciudad_digital
  match '/contact' => 'welcome#contact', :as => :contact
  match '/indexnew' => 'welcome#index_new', :as => :indexnew
  #match '/auth/lapapaya' => 'authentications#loginlapapaya'
  match '/reservations/:id/paylink/:hash' => 'reservations#paylink'
  match 'reservations/:user_id/actives' => 'reservations#actives', :as => :active_reservations
  match 'reservations/:id/aprove' => 'reservations#aprove', :as => :aprove_reservation
  match 'reservations/:id/payment' => 'reservations#payment', :as => :reservation_payment
  #match '/coworking_spaces/:id/gallery' => 'coworking_spaces#gallery'
  match '/reservations/:user/actives' => 'reservations#actives'
  match '/reservations/liberate' => 'reservations#liberate'
  match '/cart' => 'carts#show', :as => :current_cart
  match '/express' => 'orders#express', :as => :express_new_order
  match '/carts/:id/remove_item' => 'carts#remove_item'
  match '/images/:type/new' => 'images#new', :as => :newindex
  match '/user/:id/set_profile/:type' => 'user#set_profile'
  #map.current_cart 'cart', :controller => 'carts', :action => 'show', :id => 'current'
  match '/item_categories/by_coworking_space/:coworking_space_id' => 'item_categories#by_coworking_space', :as => :item_categories_by_coworking_space
  
  match '/newindex' => 'welcome#newindex', :as => :newindex
  #match '/activities/:activity_id/reservations/new' => 'reservation#new_activity_reservation', :as => :new_activity_reservation

  get 'bootstrap_test' => "welcome#bootstrap_test"
  get 'index2' => "welcome#index2"

  root :to => "welcome#index"

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
  #       get :short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get :sold'
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
  #       get :recent', :on => :collection
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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  #match  ":controller(/:action(/:id(.:format"

end
