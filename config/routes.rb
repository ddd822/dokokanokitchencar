Rails.application.routes.draw do  
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

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
