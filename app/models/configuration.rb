class Configuration < ActiveRecord::Base
  self.table_name = 'configuration'
  self.primary_key = :id

  belongs_to :console_system, :class_name => 'ConsoleSystem', primary_key: :id, foreign_key: :system_id
  belongs_to :cloud_user, :class_name => 'CloudUser', primary_key: :username, foreign_key: :creator
  belongs_to :device, :class_name => 'Device', primary_key: :id, foreign_key: :device_id
  belongs_to :console_game, :class_name => 'ConsoleGame', primary_key: :id, foreign_key: :console_game_id

  scope :by_system,->(system){
    system_ids = ConsoleSystem.where(value: system).pluck(:id)
    where(system_id: system_ids)
  }

  scope :by_user,->(user){
    user_ids = CloudUser.where(username: user).pluck(:username)
    where(creator: user_ids)
  }

  scope :by_device,->(device){
    device_ids = Device.where(name: device).pluck(:id)
    where(device_id: device_ids)
  }

  scope :by_game,->(game){
    game_ids = ConsoleGame.where(value: game).pluck(:id)
    where(console_game_id: game_ids)
  }

  scope :search_by_game,->(game){
    query = "%#{game}%"
    game_ids = ConsoleGame.where('value LIKE ?', query).pluck(:id)
    where(console_game_id: game_ids)
  }

  class Entity < Grape::Entity
    expose :id
    expose :value
    expose :device, :as => :device, using: Device::Entity
    expose :console_system, :as => :console, using: ConsoleSystem::Entity
    expose :console_game, :as => :game, using: ConsoleGame::Entity
    expose :cloud_user, :as => :creator, using: CloudUser::Entity
    expose :created_date
    expose :positive_votes
    expose :negative_votes
  end
end
