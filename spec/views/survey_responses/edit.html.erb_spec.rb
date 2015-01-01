require 'spec_helper'

describe "survey_responses/edit" do
  before(:each) do
    @survey_response = assign(:survey_response, stub_model(SurveyResponse,
      :survey => nil,
      :question => nil,
      :answer => nil
    ))
  end

  it "renders the edit survey_response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", survey_response_path(@survey_response), "post" do
      assert_select "input#survey_response_survey[name=?]", "survey_response[survey]"
      assert_select "input#survey_response_question[name=?]", "survey_response[question]"
      assert_select "input#survey_response_answer[name=?]", "survey_response[answer]"
    end
  end
end
