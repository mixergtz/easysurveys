require 'spec_helper'

describe "survey_responses/new" do
  before(:each) do
    assign(:survey_response, stub_model(SurveyResponse,
      :survey => nil,
      :question => nil,
      :answer => nil
    ).as_new_record)
  end

  it "renders new survey_response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", survey_responses_path, "post" do
      assert_select "input#survey_response_survey[name=?]", "survey_response[survey]"
      assert_select "input#survey_response_question[name=?]", "survey_response[question]"
      assert_select "input#survey_response_answer[name=?]", "survey_response[answer]"
    end
  end
end
