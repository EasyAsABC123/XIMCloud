class ConsoleGame < ActiveRecord::Base
  self.table_name = 'console_game'
  self.primary_key = :id

  has_many :configurations, :class_name => 'Configuration'

  class Entity < Grape::Entity
    expose :id
    expose :value, :as => :console_game
  end
end
