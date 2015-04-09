class Competence < ActiveRecord::Base
  has_many :topics_competences, class_name: "TopicsCompetences", dependent: :delete_all #Использую delete_all т.к. у TopicsCompetences нет ключа (соответственно, не работает destroy метод)
  has_many :topics, through: :topics_competences
end