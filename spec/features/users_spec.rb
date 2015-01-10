require 'spec_helper'

feature "User management" do

  scenario "sign up user" do
    user = FactoryGirl.build(:user)

    visit root_path
    expect{
      click_link "Sign up"
      fill_in "Email", with: user.email
      fill_in "First name", with: user.first_name
      fill_in "Last name", with: user.last_name
      select "female", :from => "Genre"
      page.find('#user_birth_date').set("1989-01-01")
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password
      click_button "Sign up"
      }.to change(User, :count).by(1)

    expect(page).to have_content "#{user.first_name} #{user.last_name}"
  end

  scenario "login user" do
    user = FactoryGirl.create(:user)
    sign_in user
    expect(page).to have_content "#{user.first_name} #{user.last_name}"
  end


end