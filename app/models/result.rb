class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :variant

  has_many :problem_zones, dependent: :delete_all
  has_many :topics, through: :problem_zones

  has_many :competence_marks, dependent: :delete_all
  has_many :competences, through: :competence_marks
end
