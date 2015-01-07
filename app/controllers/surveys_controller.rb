class SurveysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_survey, only: [:show, :edit, :update, :destroy]
  before_action :check_ownership, only: [:edit, :update, :destroy]
  before_action :check_state, only: :show

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

  private

    def set_survey
      @survey = Survey.friendly.find(params[:id])
    end


    def survey_params
      params.require(:survey).permit(:title, :logo, :description, :state, questions_attributes: [:id, :description, :_destroy, answers_attributes: [:id, :description, :_destroy]])
    end

    def check_ownership
      redirect_to surveys_url, notice: "You're not allowed to modify this survey" unless current_user.author?(@survey)
    end

    def check_state
      redirect_to surveys_url, notice: "You're not allowed to see this survey" unless current_user.author?(@survey) || @survey.published?
    end
end
