require 'spec_helper'

describe "surveys/new" do
  before(:each) do
    assign(:survey, stub_model(Survey,
      :title => "MyString",
      :description => "MyText",
      :state => 1
    ).as_new_record)
  end

  it "renders new survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", surveys_path, "post" do
      assert_select "input#survey_title[name=?]", "survey[title]"
      assert_select "textarea#survey_description[name=?]", "survey[description]"
      assert_select "input#survey_state[name=?]", "survey[state]"
    end
  end
end
