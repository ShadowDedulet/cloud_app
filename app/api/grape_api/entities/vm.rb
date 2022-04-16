class GrapeApi
  module Entities
    class Vm < Grape::Entity
      expose :id
      expose :configuration
      expose :cost, if: ->(_object, options) { options[:detail] == true }

      def configuration
        "#{object.cpu} CPU/#{object.ram} Gb"
      end

      def cost
        (object.cpu * 100) + (object.ram * 10)
      end
    end
  end
end
