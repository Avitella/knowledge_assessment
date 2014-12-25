class QuestionsVariants < ActiveRecord::Base
  belongs_to :variant
  belongs_to :questions
end
