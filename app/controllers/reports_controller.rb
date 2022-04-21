class ReportsController < ApplicationController
  before_action :set_report, only: :show

  # GET /reports or /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    fields = ValidateReportParamsService.new(params).call
    return render json: fields if fields[:err]

    report = Report.create(fields)

    ReportGeneratorJob.perform_async(report.id)

    redirect_to reports_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:report_type, :vm_amount, :output)
    end
end
