require 'spec_helper'

describe "surveys/edit" do
  before(:each) do
    @survey = assign(:survey, stub_model(Survey,
      :title => "MyString",
      :description => "MyText",
      :state => 1
    ))
  end

  it "renders the edit survey form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", survey_path(@survey), "post" do
      assert_select "input#survey_title[name=?]", "survey[title]"
      assert_select "textarea#survey_description[name=?]", "survey[description]"
      assert_select "input#survey_state[name=?]", "survey[state]"
    end
  end
end
