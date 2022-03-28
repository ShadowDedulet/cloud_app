Rails.application.routes.draw do
  resources :users
  resources :orders do
    member do
      get('approve')
    end
  end
  get('hello/index')
end
