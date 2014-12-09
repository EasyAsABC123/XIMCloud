class API < Grape::API
  prefix 'api'
  mount Cloud::User
  mount Cloud::Configurations
  mount Cloud::Game
  mount Cloud::Devices
  mount Cloud::System
  mount Cloud::Search
end