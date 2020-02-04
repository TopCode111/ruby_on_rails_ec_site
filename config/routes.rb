Rails.application.routes.draw do
  match "/404", to: "errors#not_found",as: :error_404, via: :all
  match "/500", to: "errors#internal_server_error",as: :error_500, via: :all
  scope '(:locale)', locale: /en|ja/ do
    devise_for :seller_admins, ActiveAdmin::Devise.config.merge({path: '/seller'})
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    root to: 'pages#index' #just a demo root path needs to be changed.
    get "/privacy", to: "pages#privacy"
    get "/terms_conditions", to: "pages#terms_condition"
    get '/sub_category_list' => 'items#sub_category_list'
    match '/publish_item/:id' => 'admin/items#publish_item', via: :get
    match '/unpublish_item/:id' => 'admin/items#unpublish_item', via: :get
    match '/publish_seller_item/:id' => 'seller_admins/items#publish_item', via: :get
    match '/unpublish_seller_item/:id' => 'seller_admins/items#unpublish_item', via: :get
    match '/list/:id' => 'admin/sellers#list_seller', via: :get
    match '/unlist/:id' => 'admin/sellers#unlist_seller', via: :get
    match '/list_seller/:id' => 'seller_admins/sellers#list_seller', via: :get
    match '/unlist_seller/:id' => 'seller_admins/sellers#unlist_seller', via: :get

    get '/shipping_address' => 'buyers#shipping_address'
    get '/validate_email_uniqueness' => 'users#validate_email_uniqueness'
    get '/forgot_password_authorization', to: 'users#forgot_password_authorization'

    devise_for :users, controllers: {registrations: 'registrations', passwords: 'passwords', sessions: 'sessions'}
    resources :items, only: :show do
      resources :comments, only: :create do
        post '/create_thread' => 'comments#create_thread', as: :create_thread
      end
    end
    resources :buyers, only: [:update]
    resources :payment_accounts
    resources :purchase_orders, only: [:new, :create]
    resource :order_items, only: [:create]

    #cart
    match 'cart_item/:id/destroy', to: 'carts#destroy', as: :cart_item_delete, via: :delete
    match '/cart', to: 'carts#show', as: :cart, via: :get
    get 'cart/user/sign_up', to: 'carts#cart_user_register', as: :cart_user_register
    get 'cart/user/password/new', to: 'carts#cart_new_password', as: :cart_new_password
    match 'cart/payment_accounts/new', to: 'payment_accounts#new', as: :cart_payment_account_new, via: :get
    match 'cart/payment_accounts/:id/edit', to: 'payment_accounts#edit', as: :cart_payment_account_edit, via: :get
    match 'cart/shipping_address', to: 'buyers#shipping_address', as: :cart_shipping_address, via: :get

    match "/purchase_history", to: "purchase_orders#index", as: :purchase_history, via: :get

    #buyer page
    match '/mypage', to: 'buyers#show', as: :buyer_mypage, via: :get
    get '/signup_success' => 'users#success'

    #checkout
    get 'checkout/:id/checkout_success', to: 'purchase_orders#checkout_success', as: :checkout_success
    post 'cart/:id/confirm_checkout', to: 'purchase_orders#confirm_checkout', as: :confirm_checkout


    #category_list
    match '/category/:category_name', to: 'items#index', as: :category,  via: :get
    match '/category/:category_name/:sub_category_name', to: 'items#index', as: :sub_category, via: :get
    #brand_list
    match '/brand/:brand_name', to: 'items#index', as: :brand, via: :get

    match '/seller/:seller_id', to: 'users#show', as: :seller_profile, via: :get

    get '/address_payments', to: 'buyers#address_payments'
    resources :reviews, only: :create
    match '/order/:order_id/item/:id/review', to: 'reviews#new', as: :item_review, via: :get
    match '/search' => "items#search", as: :search, via: [:get, :post]

    #follow seller
    post '/follow/:id', to: 'follows#follow', as: :follow
    post '/unfollow/:id', to: 'follows#unfollow', as: :unfollow
    get '/followings', to: 'follows#followings', as: :followings

    #comment
    get 'comment/:id/comment_threads/', to: 'comments#comment_threads', as: :comment_threads

    #seller_comment
    match '/comment/:id/new_threads' => 'seller_admins/user_comments#new_threads', via: :get, as: :new_thread
    match '/comment/:id/create_thread' => 'seller_admins/user_comments#create_thread', via: :post, as: :create_thread
    #admin_comment
    match '/comments/:id/new_threads' => 'admin/item_comments#new_threads', via: :get, as: :item_new_thread
    match '/comments/:id/create_comment_thread' => 'admin/item_comments#create_comment_thread', via: :post, as: :create_comment_thread
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'design_guide' => 'pages#design_guide'
  get 'categories' => 'pages#categories'
  get 'item' => 'pages#item'
end
