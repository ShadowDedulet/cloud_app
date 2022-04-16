class GrapeApi < Grape::API
  mount VmsApi
  mount ProjectsApi

  add_swagger_documentation
end
