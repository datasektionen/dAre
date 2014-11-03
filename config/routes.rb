DAre::Application.routes.draw  do
    resources :administrators
    resources :sessions
    resources :posts, except: [:index]
    resources :projects do
        resources :registrations
        resources :lodges
    end
    resources :settings
    resources :staff

    root to: 'static_pages#home'

    #TA BORT MATCHEN!
    #match '/auth/test',               to: 'sessions#create'

    match '/signin',                  to: 'sessions#new'
    match '/auth/:provider/callback', to: 'sessions#create'
    match '/signout',                 to: 'sessions#destroy', via: :delete

    match '/administrators/mail_all', to: 'administrators#send_mail', via: :post

    match 'projects/:project_id/registrations/:registration_id/destroy', to: 'registrations#destroy', via: :delete, :as => 'destroy_project_registration'
    match 'projects/:project_id/registrations/:registration_id/payment_mail', to: 'registrations#payment_mail', :as => 'project_registration_payment_mail'

    match 'projects/:project_id/lodges/:id/add_attendee',    to: 'lodges#add_attendee',    via: :put
    match 'projects/:project_id/lodges/:id/remove_attendee', to: 'lodges#remove_attendee', via: :put

    match 'projects/:project_id/reserves', :to => 'registrations#reserves'

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
    # match ':controller(/:action(/:id(.:format)))'
end
