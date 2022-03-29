Rails.application.routes.draw do
  root 'orders#calc'

  resources :users
  resources :orders do
    member do
      get('approve')
    end
    collection do
      get('first')
    end
  end

  get('hello/index')
end
