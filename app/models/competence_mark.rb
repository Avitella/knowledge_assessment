class CompetenceMark < ActiveRecord::Base
  belongs_to :result
  belongs_to :competence
end
