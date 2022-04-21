require_relative 'src/loaders/data_loader'
require_relative 'src/reporter'

class ReportService
  METHODS = {
    'by_price' => :find_by_price,
    'by_capacity' => :find_by_capacity,
    'by_vols_amount' => :find_by_volumes_amount,
    'by_vols_capacity' => :find_by_volumes_capacity
  }

  def initialize(report_type, vm_amount, unit_type=nil, ascending=nil, to_load: false)
    path = './app/report_service/data' 
    DataLoader.load_data("#{path}/prices.csv", "#{path}/vms.csv", "#{path}/volumes.csv") if to_load

    @report_type = report_type
    @vm_amount = vm_amount
    @unit_type = unit_type.to_sym if unit_type
    @ascending = ascending
  end

  def call
    method_to_call = Reporter.method(METHODS[@report_type])

    args = [@vm_amount, @unit_type].compact
    report = method_to_call.call(*args, ascending: @ascending)

    report.to_json
  end
end
