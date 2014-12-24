class Test < ActiveRecord::Base
  has_many :variant, dependent: :destroy
end
