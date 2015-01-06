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
    genres_summary = { male: genres_count[0], female: genres_count[1] }
  end

  def self.age_range_summary(survey_id) #Will work on Postgres?
    groups = [[18,24],[25,35],[36,44],[45,120]]
    current_year = DateTime.now.year
    groups.each do |age_group|
      range = Range.new(*age_group.map{|y| current_year - y}.reverse)
      print age_group.join(" - ")+": "
      puts SurveyResponse.where("survey_id = ?", survey_id).select(:timestamp).distinct.joins(:user).where("Year(users.birth_date) IN (?)", range).count
    end
  end

end
