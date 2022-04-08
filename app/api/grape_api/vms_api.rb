class GrapeApi
  class VmsApi < Grape::API
    format :json

    namespace :vms do
      params do
        optional :cpu, type: Integer
        optional :detail, type: Boolean, desc: 'Подробная информация о ВМ'
      end

      get do
        vms = Vm.all
        vms = vms.where('cpu >= :cpu', cpu: params[:cpu]) if params[:cpu].present?
        present vms, with: GrapeApi::Entities::Vm, detail: params[:detail]
      end

      route_param :id, type: Integer do
        get do
          vm = Vm.find_by_id(params[:id])
          error!({ message: 'ВМ не найдена' }, 404) unless vm
          present vm
        end

        delete do
          vm = Vm.find_by_id(params[:id])
          error!({ message: 'ВМ не найдена' }, 404) unless vm
          vm.destroy
          status 204
        end
      end
    end
  end
end