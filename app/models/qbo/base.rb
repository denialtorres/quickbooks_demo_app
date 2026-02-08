module Qbo
  class Base
    def self.oauth2_client
      redirect_opts = Rails.env.production? ? {} : { host: "localhost", port: 3000 }
      Rack::OAuth2::Client.new(
        identifier: ENV["QBO_CLIENT_ID"],
        secret: ENV["QBO_CLIENT_SECRET"],
        redirect_uri: Router.new.oauth2_callback_accounts_url(redirect_opts),
        authorization_endpoint: "https://appcenter.intuit.com/connect/oauth2",
        token_endpoint: "https://oauth.platform.intuit.com/oauth2/v1/tokens/bearer"
      )
    end
  end
end
