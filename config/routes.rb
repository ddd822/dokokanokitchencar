Rails.application.routes.draw do  
  
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'customers#index'
    resources :customers, only: [:index, :show, :destroy ]
    resources :shops, only: [:index, :show, :destroy ]
    resources :posts, only: [:index, :show, :destroy ]
  end

  devise_for :shops, path: 'shops', controllers: {
    sessions: 'public/shops/sessions',
    registrations: 'public/shops/registrations'
  }

  devise_for :customers, path: 'customers', controllers: {
    sessions: 'public/customers/sessions',
    registrations: 'public/customers/registrations'
  }
    
  get '/about', to: 'homes#about'
  root to: "homes#top"

  scope module: :public do
    resources :posts do
      resources :comments, only: [:create, :destroy]
    end
    
    resources :shops
    resources :customers
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
