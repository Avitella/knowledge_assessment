class Topic < ActiveRecord::Base
  belongs_to :parent, class_name: "Topic"
  has_many :children, class_name: "Topic", foreign_key: "parent_id", dependent: :destroy
  has_many :question, dependent: :destroy

  has_many :topics_competences, class_name: "TopicsCompetences", dependent: :delete_all
  has_many :competences, through: :topics_competences

  has_many :problem_zones, dependent: :delete_all
  has_many :results, through: :problem_zones
end
