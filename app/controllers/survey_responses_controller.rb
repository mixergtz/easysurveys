class SurveyResponsesController < ApplicationController
  before_action :set_survey_response, only: [:show, :edit, :update, :destroy]

  def index
    @survey_responses = SurveyResponse.all
  end

  def show
  end

  def new
    @survey_response = SurveyResponse.new
  end

  def edit
  end

  def create
    @survey_response = SurveyResponse.new(survey_response_params)
    if @survey_response.save
      redirect_to @survey_response, notice: 'Survey response was successfully created.'
    else
      render :new
    end
  end

  def update
    if @survey_response.update(survey_response_params)
      redirect_to @survey_response, notice: 'Survey response was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @survey_response.destroy
    redirect_to survey_responses_url, notice: 'Survey response was successfully destroyed.'
  end

  private

    def set_survey_response
      @survey_response = SurveyResponse.find(params[:id])
    end


    def survey_response_params
      params.require(:survey_response).permit(:survey_id, :question_id, :answer_id)
    end
end
