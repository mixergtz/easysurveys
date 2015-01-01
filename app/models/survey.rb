class Survey < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: proc { |attributes| attributes['description'].blank? }
end
