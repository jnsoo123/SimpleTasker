Hackathon::Application.routes.draw do
  resources :schedules

  resources :reminders

  resources :tasks

  devise_for :users
  get "home/index"
  
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  post '/tasks' => 'tasks#create', as: :create_task
  delete '/tasks' => 'tasks#destroy_finished_task', as: :delete_finished_task
  delete '/schedules' => 'schedules#destroy_past_schedule', as: :delete_past_schedule
  
  get '/task/search' => 'tasks#search', as: :search_task
  get '/schedule/search' => 'schedules#search', as: :search_schedule
  get '/reminder/search' => 'reminders#search', as: :search_reminder
  
  get '/users/get_users' => 'user#get_users'
  
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
  get '*path' => redirect('/')
  root 'home#index', as: 'home'
end
