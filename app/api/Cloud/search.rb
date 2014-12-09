module Cloud
  class Search < Grape::API
    ActiveRecord::Base.establish_connection(:adapter => 'mysql', :database => 'XIM', :username => 'root', :password => '', :host => 'localhost')
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    version 'v1', using: :header, vendor: 'xim'
    format :json

    resource :search do
      desc 'Returns all configurations for the text like game.'
      params do
        requires :game_name, type: String, desc: 'Game name that you want the configurations for.', documentation: { example: 'Battlefield' }
      end
      get 'game/:game_name' do
        configs = Configuration.search_by_game(params[:game_name])
        present :data, configs, :with => Configuration::Entity
        present :status, 'Success'
      end

      desc 'Returns all configurations for the text like game.'
      params do
        requires :game_name, type: String, desc: 'Game name that you want the configurations for.', documentation: { example: 'Battlefield' }
      end
      get 'device/:device/game/:game_name' do
        configs = Configuration.search_by_game(params[:game_name])
        present :data, configs, :with => Configuration::Entity
        present :status, 'Success'
      end
    end
  end
end