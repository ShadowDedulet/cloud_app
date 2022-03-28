Rails.application.routes.draw do
  resources :users
  resources :orders
  get('hello/index')
end
