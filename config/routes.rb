Rails.application.routes.draw do
  resources :reports
  resources :groups
  mount GrapeApi => '/api'
  mount GrapeSwaggerRails::Engine => '/swagger'

  mount Sidekiq::Web => '/sidekiq'

  resources :reports
  
  resources :hdds
  resources :vms
  resources :projects
  root 'orders#calc'

  resource :login, only: %i[show create destroy]

  resources :users
  resources :orders do
    collection do
      get('check')
    end
  end

  resources :vms, only: [:index]

  get('hello/index')
end
