class OauthJwt < ActiveRecord::Base
    self.table_name = 'oauth_jwt'
    self.primary_key = :client_id

end
