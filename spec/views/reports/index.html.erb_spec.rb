require 'rails_helper'

RSpec.describe "reports/index", type: :view do
  before(:each) do
    assign(:reports, [
      Report.create!(
        report_type: 2,
        vm_amount: 3,
        output: ""
      ),
      Report.create!(
        report_type: 2,
        vm_amount: 3,
        output: ""
      )
    ])
  end

  it "renders a list of reports" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
