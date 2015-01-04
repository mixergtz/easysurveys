class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :surveys, dependent: :destroy
  has_many :survey_responses, dependent: :destroy

  enum genre: [:male, :female]
end
