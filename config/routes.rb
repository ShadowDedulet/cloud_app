Rails.application.routes.draw do
  resources :groups
  mount GrapeApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'

  mount Sidekiq::Web => '/sidekiq'

  resources :hdds
  resources :vms
  resources :projects
  root 'orders#calc'

  resource :login, only: %i[show create destroy]

  resources :users
  resources :orders do
    member do
      get('approve')
    end
    collection do
      get('first')
    end
  end

  resources :vms, only: [:index]

  get('hello/index')
end
