class AddUserToSurveyAndSurveyResponses < ActiveRecord::Migration
  def change
    add_column :surveys, :user_id, :integer
    add_index :surveys, :user_id
    add_column :survey_responses, :user_id, :integer
    add_index :survey_responses, :user_id
  end
end
