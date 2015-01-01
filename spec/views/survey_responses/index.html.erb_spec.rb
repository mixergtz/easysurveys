require 'spec_helper'

describe "survey_responses/index" do
  before(:each) do
    assign(:survey_responses, [
      stub_model(SurveyResponse,
        :survey => nil,
        :question => nil,
        :answer => nil
      ),
      stub_model(SurveyResponse,
        :survey => nil,
        :question => nil,
        :answer => nil
      )
    ])
  end

  it "renders a list of survey_responses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
