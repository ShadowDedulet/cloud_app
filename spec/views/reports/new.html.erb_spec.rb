require 'rails_helper'

RSpec.describe "reports/new", type: :view do
  before(:each) do
    assign(:report, Report.new(
      report_type: 1,
      vm_amount: 1,
      output: ""
    ))
  end

  it "renders new report form" do
    render

    assert_select "form[action=?][method=?]", reports_path, "post" do

      assert_select "input[name=?]", "report[report_type]"

      assert_select "input[name=?]", "report[vm_amount]"

      assert_select "input[name=?]", "report[output]"
    end
  end
end
