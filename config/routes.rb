Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # root to: 'contracts#home'
  root 'sessions#new'
  get 'home', to: 'contracts#home'
  
  resources :items
  resources :commodities
  resources :sizes
  resources :varieties
  resources :grades
  resources :accounts
  resources :users
  resources :sessions
  resources :orders
  resources :invoices
  resources :origins
  resources :terms
  resources :remarks
  resources :delivery_locations
  resources :shipping_instructions, only: [:show]
  
  get 'contracts/:id/contract_report' => 'contracts#contract_report', as: :contract_report
  get 'invoices/:id/invoice_report' => 'invoices#invoice_report', as: :invoice_report 
  # get 'shipping_instructions/:id' => 'shipping_instructions#show'
  get 'orders/:id/shipping_report' => 'orders#shipping_report', as: :shipping_report
  get 'ajax/item_names' => 'ajax#item_names', as: :item_names
  get 'ajax/filter_items_by_variety' => 'ajax#filter_items_by_variety', as: :filter_items_by_variety

  resources :documents
  get 'sign_in' => 'sessions#new'
  get 'sign_out' => 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'
  resources :contracts do
    resource :orders
  end
  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
