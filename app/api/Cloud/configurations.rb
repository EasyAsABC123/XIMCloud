module Cloud
  class Configurations < Grape::API
    ActiveRecord::Base.establish_connection(:adapter => 'mysql', :database => 'XIM', :username => 'root', :password => '', :host => 'localhost')
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    version 'v1', using: :header, vendor: 'xim'
    format :json
    resource :configuration do
      desc 'Returns all configurations.'
      get do
        configs = Configuration.includes(:device, :console_system, :cloud_user, :console_game)
        present :data, configs, :with => Configuration::Entity
        present :status, 'Success'
      end

      desc 'Returns all configurations for the specified device.'
      params do
        requires :device_name, type: String, desc: 'Device name that you want the configurations for.', documentation: { example: 'XIM 4' }
      end
      get 'device/:device_name' do
        configs = Configuration.by_device(params[:device_name])
        present :data, configs, :with => Configuration::Entity
        present :status, 'Success'
      end

      desc 'Returns all configurations for the specified game.'
      params do
        requires :game_name, type: String, desc: 'Game name that you want the configurations for.', documentation: { example: 'Battlefield 4' }
      end
      get 'game/:game_name' do
        configs = Configuration.by_game(params[:game_name])
        present :data, configs, :with => Configuration::Entity
        present :status, 'Success'
      end

      desc 'Returns all configurations for the specified user.'
      params do
        requires :username, type: String, desc: 'Username that you want to search configurations for.', documentation: { example: 'Muken' }
      end
      get 'user/:username' do
        configs = Configuration.by_user(params[:username])
        present :data, configs, :with => Configuration::Entity
        present :status, 'Success'
      end

      desc 'Returns all configurations for the specified system.'
      params do
        requires :console_system, type: String, desc: 'Console that you want the configurations for.', documentation: { example: 'Xbox One' }
      end
      get 'system/:console_system' do
        configs = Configuration.by_system(params[:console_system])
        present :data, configs, :with => Configuration::Entity
        present :status, 'Success'
      end
    end
  end
end