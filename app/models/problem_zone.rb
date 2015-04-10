class ProblemZone < ActiveRecord::Base
  belongs_to: :result
  belongs_to: :topic
end
