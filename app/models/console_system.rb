class ConsoleSystem < ActiveRecord::Base
    self.table_name = 'console_system'
    self.primary_key = :id

    has_many :configurations, :class_name => 'Configuration'

    class Entity < Grape::Entity
      expose :id
      expose :value, :as => :console_system
    end
end
