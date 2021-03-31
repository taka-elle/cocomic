Rails.application.routes.draw do
  root to: "tops#index"

  devise_for :shops, controllers: {
    sessions: 'shops/sessions',
    passwords: 'shops/passwords',
    registrations: 'shops/registrations'
  }
  resources :shops,only:[:show]
  resources :shop_data,only:[:new,:create,:edit,:update]
  resources :shop_items,only:[:new,:create,:show,:destroy] do
    collection do
      get 'search'
    end
    resources :tickets,only:[:new,:create,:destroy,:edit]
  end

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations'
    }do
  end
  
  resources :items,only:[:index]
end
