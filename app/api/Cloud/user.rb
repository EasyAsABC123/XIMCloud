module Cloud
  class User < Grape::API
    ActiveRecord::Base.establish_connection(:adapter => 'mysql', :database => 'XIM', :username => 'root', :password => '', :host => 'localhost')
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    version 'v1', using: :header, vendor: 'xim'
    format :json
    resource :user do
      desc 'Returns all users.'
      get do
        users = CloudUser.all
        present :data, users, :with => CloudUser::Entity
        present :status, 'Success'
      end

      desc 'Returns a user with the specified username.'
      params do
        requires :username, type: String, desc: 'Username lookup (full username required).', documentation: { example: 'abc123' }
      end
      route_param :username do
        get do
          users = CloudUser.where(:username => params[:username])
          present :data, users, :with => CloudUser::Entity
          present :status, 'Success'
        end
      end

      desc 'Search for a user.'
      params do
        requires :username, type: String, desc: 'Username search.', documentation: { example: 'uke' }
      end
      get 'search/:username' do
        users = CloudUser.where('username like ?', "%#{params[:username]}%")
        present :data, users, :with => CloudUser::Entity
        present :status, 'Success'
      end
    end
  end
end