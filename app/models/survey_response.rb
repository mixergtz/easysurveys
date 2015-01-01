class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  belongs_to :answer


  def self.save_response(question_id, answer_id)
    question = Question.find(question_id) #Se podria hacer con el params :survey_id?
    create(survey_id: question.survey.id, question_id: question_id, answer_id: answer_id)
  end

end
