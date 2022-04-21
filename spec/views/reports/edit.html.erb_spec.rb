require 'rails_helper'

RSpec.describe "reports/edit", type: :view do
  before(:each) do
    @report = assign(:report, Report.create!(
      report_type: 1,
      vm_amount: 1,
      output: ""
    ))
  end

  it "renders the edit report form" do
    render

    assert_select "form[action=?][method=?]", report_path(@report), "post" do

      assert_select "input[name=?]", "report[report_type]"

      assert_select "input[name=?]", "report[vm_amount]"

      assert_select "input[name=?]", "report[output]"
    end
  end
end
