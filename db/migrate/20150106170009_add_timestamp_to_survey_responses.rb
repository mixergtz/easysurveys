class AddTimestampToSurveyResponses < ActiveRecord::Migration
  def change
    add_column :survey_responses, :timestamp, :integer
  end
end
