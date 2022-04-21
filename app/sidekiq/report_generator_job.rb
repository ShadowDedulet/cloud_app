require_relative '../report_service/report_service'

class ReportGeneratorJob
  include Sidekiq::Job
  
  sidekiq_options retry: false

  def initialize
    @load = true
  end

  def perform(report_id)
    report = Report.find(report_id)
    
    result = ReportService.new(report.report_type, report.vm_amount, report.unit_type, report.ascending, to_load: @load).call
    @load = false
    
    report.output = result
    report.save
    
  end
end
