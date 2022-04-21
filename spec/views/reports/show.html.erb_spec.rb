require 'rails_helper'

RSpec.describe "reports/show", type: :view do
  before(:each) do
    @report = assign(:report, Report.create!(
      report_type: 2,
      vm_amount: 3,
      output: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(//)
  end
end
