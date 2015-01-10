class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :surveys, dependent: :destroy
  has_many :survey_responses, dependent: :destroy
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :birth_date

  enum genre: [:male, :female]

  def author?(survey)
    self.id == survey.user_id
  end
end
