Rails.application.routes.draw do
  resources :orders
  get('hello/index')
end
