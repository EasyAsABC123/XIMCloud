module Cloud
  class Game < Grape::API
    ActiveRecord::Base.establish_connection(:adapter => 'mysql', :database => 'XIM', :username => 'root', :password => '', :host => 'localhost')
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    version 'v1', using: :header, vendor: 'xim'
    format :json

    resource :game do
      desc 'Returns all games.'
      get do
        games = ConsoleGame.all
        present :data, games, :with => ConsoleGame::Entity
        present :status, 'Success'
      end

      desc 'Search for a game.'
      params do
        requires :value, type: String, desc: 'Game search.', documentation: { example: 'battlefield' }
      end
      route_param :value do
        get do
          games = ConsoleGame.where('value like ?', "%#{params[:value]}%")
          present :data, games, :with => ConsoleGame::Entity
          present :status, 'Success'
        end
      end
    end
  end
end