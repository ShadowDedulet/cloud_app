class GrapeApi
  class ProjectsApi < Grape::API
    format :json

    namespace :projects do
      params do
        optional :state, type: [String, Array]
      end
      
      get do 
        projects = Project.all.where(state: params[:state]) if params[:state].present?

        present projects
      end

      post do
          unless params[:name].present? && params[:state].present?
            error!({ error: 'Wrong params' }, 406) 
          end
          project = Project.create(name: params[:name], state: params[:state])
          present project
      end

      route_param :id, type: Integer do
        get do
          project = Project.find_by_id(params[:id])
          error!({ error: 'Project not found' }, 404) unless project
          present project
        end

        delete do
          project = Project.find_by_id(params[:id])
          error!({ error: 'Project not found' }, 404) unless project
          project.destroy
          status 204
        end
      end

    end
  end
end