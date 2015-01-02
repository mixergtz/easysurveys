class SurveyResponsesController < ApplicationController

  def index
    @survey_responses = SurveyResponse.get_questions(params[:survey_id])
  end

  def create
    answers = params[:survey_responses][:questions_answers]
    answers.each do |question, answer|
      SurveyResponse.save_response(question, answer)
    end

  end

  private

    def survey_response_params
      params.require(:survey_responses).permit(:questions_answers)
    end
end
