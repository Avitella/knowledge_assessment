class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answer, dependent: :destroy
end
