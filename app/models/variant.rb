class Variant < ActiveRecord::Base
  belongs_to :test
  has_and_belongs_to_many :question
end
