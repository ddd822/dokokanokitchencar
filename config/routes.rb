Rails.application.routes.draw do  
  devise_for :shops, path: 'shops', controllers: {
  sessions: 'public/shops/sessions',
  registrations: 'public/shops/registrations'
}

devise_for :customers, path: 'customers', controllers: {
  sessions: 'public/customers/sessions',
  registrations: 'public/customers/registrations'
}
  
  scope module: :public do
    resources :posts
    resources :shops
    resources :customers
  end

  get '/about', to: 'homes#about'
  root to: "homes#top"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
