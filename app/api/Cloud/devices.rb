module Cloud
  class Devices < Grape::API
    ActiveRecord::Base.establish_connection(:adapter => 'mysql', :database => 'XIM', :username => 'root', :password => '', :host => 'localhost')
    ActiveRecord::Base.logger = Logger.new(STDOUT)

    version 'v1', using: :header, vendor: 'xim'
    format :json

    resource :device do
      desc 'Returns all devices.'
      get do
        devices = Device.all
        present :data, devices, :with => Device::Entity
        present :status, 'Success'
      end
    end
  end
end