class CloudUser < ActiveRecord::Base
    self.primary_key = :username

    has_many :configurations, :class_name => 'Configuration'
    has_many :favorites, :class_name => 'Favorite', :foreign_key => :username

    class Entity < Grape::Entity
      expose :username, :email, :first_name, :last_name
    end
end
