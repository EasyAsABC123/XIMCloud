class Favorite < ActiveRecord::Base
    self.table_name = 'favorite'


    belongs_to :configuration, :class_name => 'Configuration', :foreign_key => :configuration_id    
    belongs_to :cloud_user, :class_name => 'CloudUser', :foreign_key => :username    
end
