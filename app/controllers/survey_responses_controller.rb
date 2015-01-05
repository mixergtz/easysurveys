class SurveyResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_ownership, only: :create

  def index
    @survey_responses = SurveyResponse.get_questions(params[:survey_id])
  end

  def create
    survey = params[:survey_id]
    answers = params[:survey_responses][:questions_answers]
    answers.each do |question, answer|
      SurveyResponse.save_response(question, answer, current_user.id)
    end
    redirect_to survey_responses_path(survey) #hacer un redirect a una pagina de gracias
  end

  private

    def survey_response_params
      params.require(:survey_responses).permit(:questions_answers)
    end

    def check_ownership
      @survey = Survey.find(params[:survey_id])
      redirect_to surveys_url, notice: "You're not allowed to send responses to this survey" if current_user.author?(@survey)
    end
end
