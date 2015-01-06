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
    range_18_25  = where("survey_id = ?", survey_id).select(:timestamp).distinct.joins(:user).where("age(users.birth_date) BETWEEN '18 year'::interval AND '25 year'::interval ").count
    range_26_35  = where("survey_id = ?", survey_id).select(:timestamp).distinct.joins(:user).where("age(users.birth_date) BETWEEN '26 year'::interval AND '35 year'::interval ").count
    range_36_45  = where("survey_id = ?", survey_id).select(:timestamp).distinct.joins(:user).where("age(users.birth_date) BETWEEN '36 year'::interval AND '45 year'::interval ").count
    range_45  = where("survey_id = ?", survey_id).select(:timestamp).distinct.joins(:user).where("age(users.birth_date) > '45 year'::interval ").count
    { "18 to 25" => range_18_25, "26 to 35" => range_26_35, "36 to 45" => range_36_45, "45+" => range_45 }
  end

end
