class Device < ActiveRecord::Base
    self.table_name = 'device'
    self.primary_key = :id

    has_many :configurations, :class_name => 'Configuration'

    class Entity < Grape::Entity
      expose :id
      expose :name, :as => :device
    end
end
