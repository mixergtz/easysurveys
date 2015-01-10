require 'spec_helper'

describe User do
  it "is invalid without email" do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).to have(1).errors_on(:email)
  end

  it "is invalid without first_name" do
    user = FactoryGirl.build(:user, first_name: nil)
    expect(user).to have(1).errors_on(:first_name)
  end

  it "is invalid without last_name" do
    user = FactoryGirl.build(:user, last_name: nil)
    expect(user).to have(1).errors_on(:last_name)
  end

  it "is invalid without birth_date" do
    user = FactoryGirl.build(:user, birth_date: nil)
    expect(user).to have(1).errors_on(:birth_date)
  end

  it "should return true if is author of a survey" do
    user = FactoryGirl.create(:user)
    survey = FactoryGirl.create(:survey, user: user)
    expect(user.author?(survey)).to be_true
  end

  it "should return false if is not the author of a survey" do
    user = FactoryGirl.create(:user)
    survey = FactoryGirl.create(:survey)
    expect(user.author?(survey)).to be_false
  end
end
