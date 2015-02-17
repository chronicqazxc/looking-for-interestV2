Rails.application.routes.draw do
  get 'stores/menu'
  post 'stores/get_minor_types'
  post 'stores/change_minor_type'
  post 'stores/get_locations'
  post 'minor_types/get_last_minor_type'
  get 'session/welcome'
  post 'session/login'
  get 'session/register'
  get 'session/logout'
  post 'users/user_register'
  get 'users/register'
  get 'details/edit'
  get 'comments/edit'
  get 'parse_jsons/transfor_address'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
    resources :welcome
    resources :stores
    resources :manage
    resources :major_types
    resources :minor_types
    resources :details
    resources :comments
    resources :users
    resources :session, only: [:create, :destroy]
    resources :parse_jsons
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
namespace :api do
  namespace :v1  do
    resources :tokens,:only => [:index, :create, :destroy]
  end
end

  get  'api/v1/tokens/test'
  post 'api/v1/datas/get_stores'
  get  'api/v1/datas/menu'
  post 'api/v1/datas/get_ranges'
  post 'api/v1/datas/get_init_menus'
  post 'api/v1/datas/get_stores'
  post 'api/v1/datas/get_major_types'
  post 'api/v1/datas/get_minor_types'  
  post 'api/v1/datas/get_stores_from_my_position'  
end
