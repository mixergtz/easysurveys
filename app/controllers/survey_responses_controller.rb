class SurveyResponsesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survey
  before_action :check_ownership, only: :index
  before_action :protect_from_owner, only: :create

  def index
    @survey_responses = SurveyResponse.get_questions(@survey)
    @survey_responders = SurveyResponse.get_responders(@survey)
    @responses_number = SurveyResponse.responses_number(@survey)
  end

  def create
    answers = params[:survey_responses][:questions_answers]
    answers.each do |question, answer|
      SurveyResponse.create(survey_id: params[:survey_id], question_id: question, answer_id: answer, user_id: current_user.id, timestamp: Time.now.to_i)
    end
    render :thanks
  end

  private

    def set_survey
      @survey = Survey.friendly.find(params[:survey_id])
    end

    def survey_response_params
      params.require(:survey_responses).permit(:questions_answers)
    end

    def protect_from_owner
      redirect_to surveys_url, notice: "You're not allowed to send responses to this survey" if current_user.author?(@survey)
    end

    def check_ownership
      redirect_to surveys_url, notice: "You're not allowed to see the responses of this survey" unless current_user.author?(@survey)
    end
end
