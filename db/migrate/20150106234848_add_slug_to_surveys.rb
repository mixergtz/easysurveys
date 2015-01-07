class AddSlugToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :slug, :string, unique: true
  end
end
