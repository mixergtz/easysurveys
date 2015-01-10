require 'spec_helper'

feature "Creating survey" do

  background do
    user = FactoryGirl.create(:user)
    @survey = FactoryGirl.build(:survey, user: user)
    @question1 = FactoryGirl.build(:question, survey: @survey)
    @answer1 = FactoryGirl.build(:answer, question: @question1)
    @answer2 = FactoryGirl.build(:answer, question: @question1)
    @question2 = FactoryGirl.build(:question, survey: @survey)
    @answer3 = FactoryGirl.build(:answer, question: @question2)
    @answer4 = FactoryGirl.build(:answer, question: @question2)

    # Question/answer to be added on "Add question" link
    @question_extra = FactoryGirl.build(:question, survey: @survey)
    @answer_extra = FactoryGirl.build(:answer, question: @question_extra)

    sign_in user
    visit surveys_path
    click_link "New Survey"
    fill_in "Title", with: @survey.title
    fill_in "Description", with: @survey.description
    fill_in "survey_questions_attributes_0_description", with: @question1.description
    fill_in "survey_questions_attributes_0_answers_attributes_0_description", with: @answer1.description
    fill_in "survey_questions_attributes_0_answers_attributes_1_description", with: @answer2.description
    fill_in "survey_questions_attributes_1_description", with: @question2.description
    fill_in "survey_questions_attributes_1_answers_attributes_0_description", with: @answer3.description
    fill_in "survey_questions_attributes_1_answers_attributes_1_description", with: @answer4.description
  end

  context "With valid information" do

    scenario "should create a survey, two questions and four answers and show survey" do
      expect { click_button "Submit" }.to change { [Survey.count, Question.count, Answer.count] }.to([1,2,4])
      # It redirects to show page and must have this fields
      expect(page).to have_content @survey.title
      expect(page).to have_content @survey.description
      expect(page).to have_content @question1.description
      expect(page).to have_content @answer1.description
      expect(page).to have_content @answer2.description
      expect(page).to have_content @question2.description
      expect(page).to have_content @answer3.description
      expect(page).to have_content @answer4.description
    end

    scenario "should create a new question field when pressed Add Question and save it", :js => true do

      click_link("Add Question", match: :first)
      page.assert_selector('fieldset.question', :count => 3)

      # Fill in question and answer
      within(:css, 'fieldset.question:nth-child(1)') do
        fill_in 'Question', with: @question_extra.description
        click_link "Add Answer"
        fill_in 'Answer', with: @answer_extra.description
      end
      click_button "Submit"

      # Expect counts
      expect(Survey.count).to eq(1)
      expect(Question.count).to eq(3)
      expect(Answer.count).to eq(5)

      # Check content
      expect(page).to have_content @question_extra.description
      expect(page).to have_content @answer_extra.description

    end

    scenario "should remove a question field when pressed (remove)", :js => true do
      click_link("remove", match: :first)
      expect(page).to have_selector('fieldset.question', count: 1)
    end

  end

  context "With invalid information" do

    scenario "should not create a survey, questions or answers" do
      fill_in "Title", with: nil
      expect { click_button "Submit" }.to_not change { [Survey.count, Question.count, Answer.count] }
      expect(page).to have_css('div.errors')
    end

  end

end

feature "Editing or destroy survey" do

  background do
    user = FactoryGirl.create(:user)
    @survey = FactoryGirl.create(:survey, user: user)
    question1 = FactoryGirl.create(:question, survey: @survey)
    answer1 = FactoryGirl.create(:answer, question: question1)
    answer2 = FactoryGirl.create(:answer, question: question1)
    question2 = FactoryGirl.create(:question, survey: @survey)
    answer3 = FactoryGirl.create(:answer, question: question2)
    answer4 = FactoryGirl.create(:answer, question: question2)

    sign_in user
  end

  context "With valid information" do

    scenario "should show edited info" do
      visit edit_survey_path(@survey)
      fill_in "Title", with: "Survey edited"
      click_button "Submit"
      expect(page).to have_content "Survey edited"
    end

  end

  context "With invalid information" do

    scenario "should not edit survey" do
      visit edit_survey_path(@survey)
      fill_in "Title", with: nil
      click_button "Submit"
      expect(page).to have_css('div.errors')
    end

  end

  context "destroy survey" do
      scenario "should click destroy survey and delete", :js => true do
          visit surveys_path
          click_link("Destroy", match: :first)
          #page.evaluate_script('window.confirm = function() { return true; }')
          page.driver.browser.switch_to.alert.accept
          assert [Survey.count, Question.count, Answer.count] == [0,0,0]
      end
  end

end



