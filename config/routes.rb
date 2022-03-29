Rails.application.routes.draw do
  root 'orders#calc'

  resources :users
  resources :orders do
    member do
      get('approve')
    end
  end

  get('hello/index')
end
