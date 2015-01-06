class SurveyResponse < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question
  belongs_to :answer
  belongs_to :user

  scope :responses_number, ->(survey_id) { where("survey_id = ?", survey_id).select(:timestamp).distinct.count }
  scope :get_questions, ->(survey_id) { where("survey_id = ?", survey_id).select(:question_id).distinct }
  scope :question_summary, ->(id) { where("survey_responses.question_id = ?", id).joins(:answer).group("answers.description").count }
  scope :get_responders, ->(survey_id) { where("survey_id = ?", survey_id).select(:user_id).distinct }

  def self.genres_summary(survey_id)
    genres_count = where("survey_id = ?", survey_id).select(:timestamp).distinct.joins(:user).group("users.genre").count
    genres_summary = { "#{User.genres.keys[0]}" => genres_count[0], "#{User.genres.keys[1]}" => genres_count[1] }
  end

  def self.age_range_summary(survey_id)
    where("survey_id = ?", 6).select(:timestamp).distinct.joins(:user).group("users.genre").count
  end

end
