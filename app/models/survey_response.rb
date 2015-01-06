class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  belongs_to :answer
  belongs_to :user

  scope :get_questions, ->(survey_id) { where("survey_id = ?", survey_id).select(:question_id).distinct }
  scope :question_summary, ->(id) { where("survey_responses.question_id = ?", id).joins(:answer).group("answers.description").count }
  scope :get_responders, ->(survey_id) { where("survey_id = ?", survey_id).select(:user_id).distinct }

  def self.save_response(question_id, answer_id, user_id)
    question = Question.find(question_id) #Se podria hacer con el params :survey_id?
    create(survey_id: question.survey.id, question_id: question_id, answer_id: answer_id, user_id: user_id)
  end

end
