class AddDefaultStatusToSurvey < ActiveRecord::Migration
  def change
    change_column :surveys, :state, :integer, default: 0
  end
end
