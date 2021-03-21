Rails.application.routes.draw do
  devise_for :shops, controllers: {
    sessions: 'shops/sessions',
    passwords: 'shops/passwords',
    registrations: 'shops/registrations'
  }
  resources :shops,only:[:show]

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
    }do
  end
  
  root to: "tops#index"
  
  resources :items,only:[:index]
  
  resources :shop_items,only:[:new,:create,:show,:destroy] do
    collection do
      get 'search'
    end
    resources :tickets,only:[:new,:create,:destroy,:edit]
  end
end
