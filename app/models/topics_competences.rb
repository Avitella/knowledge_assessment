class TopicsCompetences < ActiveRecord::Base
  belongs_to :topic
  belongs_to :competence
end
