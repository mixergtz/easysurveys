class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  belongs_to :answer

  scope :question_summary, ->(id) { where("question_id = ?", id).group(:answer_id).count }
  scope :get_questions, ->(survey_id) { where("survey_id = ?", survey_id).select(:question_id).distinct } #se podria convertir a objetos question desde aca?


  def self.save_response(question_id, answer_id)
    question = Question.find(question_id) #Se podria hacer con el params :survey_id?
    create(survey_id: question.survey.id, question_id: question_id, answer_id: answer_id)
  end

end
