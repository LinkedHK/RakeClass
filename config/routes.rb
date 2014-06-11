Rails.application.routes.draw do
  resources :statuses
  resource :cli

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products


  #get ':controller(/:action/:name)', controller: 'clients'

  root  to: 'slap_items#index'

  get '/' , to: 'slap_items#index', as: 'slap_index'
  get '/items/:pg' , to: 'slap_items#index', as: 'slap_pagination'
  get 'slap_items/operation/edit/:id', to: 'slap_items#edit', as: 'slap_item_edit'
  get 'slap_items/operation/new', to: 'slap_items#new', as: 'slap_item_new'
  post 'slap_items/operation/update/:id', to: 'slap_items#update_item', as: 'slap_item_update'
  post 'slap_items/operation/create', to: 'slap_items#create', as: 'slap_item_create'

  get '/usr' , to: 'auth_user#index', as: 'auth_user_index'
  get '/usr/login' , to: 'auth_user#login', as: 'auth_user_login'
  post '/usr/login' , to: 'auth_user#post_login', as: 'auth_post_login'
  get '/usr/signup' , to: 'auth_user#signup', as: 'auth_user_signup'
  post '/usr/signup' , to: 'auth_user#post_signup', as: 'auth_post_signup'

  #resource :slap_items
#get ':controller(/:action)', controller: 'slap_items'

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
