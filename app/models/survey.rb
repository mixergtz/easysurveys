class Survey < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged]

  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :survey_responses, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }
  mount_uploader :logo, SurveyLogoUploader
  enum state: [:draft, :published]
  validate :logo_size



  private

  def logo_size
    if logo.size > 1.megabytes
      errors.add(:logo, "should be less than 1MB")
    end
  end
end
