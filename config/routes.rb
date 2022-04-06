Rails.application.routes.draw do
  root 'orders#calc'

  resource :login, only: [:show, :create, :destroy]

  resources :users
  resources :orders do
    member do
      get('approve')
    end
    collection do
      get('first')
      get('check')
    end
  end

  get('hello/index')
end
