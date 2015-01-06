class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  belongs_to :answer
  belongs_to :user

  scope :get_questions, ->(survey_id) { where("survey_id = ?", survey_id).select(:question_id).distinct } #se podria convertir a objetos question desde aca?
  scope :question_summary, ->(id) { where("survey_responses.question_id = ?", id).joins(:answer).group("answers.description").count }

  def self.save_response(question_id, answer_id, user_id)
    question = Question.find(question_id) #Se podria hacer con el params :survey_id?
    create(survey_id: question.survey.id, question_id: question_id, answer_id: answer_id, user_id: user_id)
  end

end
