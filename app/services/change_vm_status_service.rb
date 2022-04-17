require_relative 'fetch_service'
require 'json'

class ChangeVmStatusService
  def self.call(payload)
    data = FetchService.fetch('http://app:3000/orders/change_status', JSON.parse(payload))
    pp(data)
  end
end
