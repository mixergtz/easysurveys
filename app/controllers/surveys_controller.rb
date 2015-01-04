class SurveysController < ApplicationController
  before_action :set_survey, only: [:show, :edit, :update, :destroy]

  def index
    @surveys = Survey.all
  end

  def show
    @survey_response = SurveyResponse.new
  end

  def new
    @survey = Survey.new
    2.times do
      question = @survey.questions.build
      3.times { question.answers.build }
    end
  end

  def edit
  end

  def create
    @survey = current_user.surveys.new(survey_params)

    if @survey.save
      redirect_to @survey, notice: 'Survey was successfully created.'
    else
      render :new
    end

  end

  def update

    if @survey.update(survey_params)
      redirect_to @survey, notice: 'Survey was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @survey.destroy
    redirect_to surveys_url, notice: 'Survey was successfully destroyed.'
  end

  def send_response
    answers = params[:survey_answers][:questions_answers]
    answers.each_value {|value| puts value }
  end

  private

    def set_survey
      @survey = Survey.find(params[:id])
    end


    def survey_params
      params.require(:survey).permit(:title, :description, :state, questions_attributes: [:id, :description, :_destroy, answers_attributes: [:id, :description, :_destroy]])
    end
end
