class Question < ActiveRecord::Base
  belongs_to :survey

  has_many :survey_responses, dependent: :destroy
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }
end
