module Cloud
  class System < Grape::API
    ActiveRecord::Base.establish_connection(:adapter => 'mysql', :database => 'XIM', :username => 'root', :password => '', :host => 'localhost')
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    version 'v1', using: :header, vendor: 'xim'
    format :json

    resource :system do
      desc 'Returns all systems.'
      get do
        systems = ConsoleSystem.all
        present :data, systems, :with => ConsoleSystem::Entity
        present :status, 'Success'
      end
    end
  end
end