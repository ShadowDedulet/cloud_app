Rails.application.routes.draw do
  resources :groups
  mount GrapeApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'

  mount Sidekiq::Web => '/sidekiq'

  resources :hdds
  resources :vms
  resources :projects

  resource :login, only: %i[show create destroy]

  resources :users
  resources :orders do
    collection do
      get('check')
      get('change_status')
    end
  end

  resources :vms, only: [:index]

  get('hello/index')
end
