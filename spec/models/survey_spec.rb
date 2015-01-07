require 'spec_helper'

describe Survey do

  it "is invalid without a title" do
    survey = FactoryGirl.build(:survey, title: nil)
    expect(survey).to have(1).errors_on(:title)
  end

  it "is invalid without a user" do
    survey = FactoryGirl.build(:survey, user: nil)
    expect(survey).to_not be_valid
  end

  it "is created as a draft" do
    survey = FactoryGirl.create(:survey)
    expect(survey.state).to eq "draft"
  end

end
