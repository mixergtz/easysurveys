require 'spec_helper'

describe "survey_responses/show" do
  before(:each) do
    @survey_response = assign(:survey_response, stub_model(SurveyResponse,
      :survey => nil,
      :question => nil,
      :answer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
