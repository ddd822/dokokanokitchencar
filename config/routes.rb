Rails.application.routes.draw do  
  
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'customers#index'
    resources :customers, only: [:index, :show, :destroy ] do
      collection do
        get :search
      end
    end

    resources :shops, only: [:index, :show, :destroy ] do
      collection do
        get :search
      end
    end
    
    resources :posts, only: [:index, :show, :destroy ] do
      collection do
        get :search
      end
      resources :comments, only: [:destroy]
      resources :tags, only: [:index,:destroy]
    end
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
      collection do
        get :search
      end
      resources :comments, only: [:create, :destroy]
    end
    resources :tags, only: [:index]
    resources :shops
    resources :customers
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
