namespace :quickbooks do
  desc "Renew OAuth2 tokens"
  task renew_oauth2_tokens: :environment do
    # Select appropriate logger - use Crono.logger if available, otherwise Rails.logger
    logger = (defined?(Crono) && Crono.logger) || Rails.logger

    msg = "Start Crono FLAG #{self}"
    logger.info msg
    p msg

    if (qbo_accounts = QboAccount.expired).empty?
      msg = "QAUTH2_RENEW_TOKEN: nothing to do"
      logger.info msg
      p msg
    else
      qbo_accounts.each do |qbo_account|
        logger.info "Running Refresh Code"
        begin
          client = Qbo::Base.oauth2_client
          client.refresh_token = qbo_account.refresh_token

          if response = client.access_token!
            attrs = { token: response.access_token, refresh_token: response.refresh_token }.merge(QboAccount.oauth2_expiry_attrs)
            logger.info attrs.to_s

            if qbo_account.update(attrs)
              msg = "SUCCESS_OAUTH2_RENEW_TOKEN: qbo_account: #{qbo_account.id}"
              logger.info msg
              p msg
            else
              msg = "FAILED_OAUTH2_RENEW_TOKEN: qbo_account: #{qbo_account.id} error_message: #{response}"
              logger.error msg
              p msg
            end
          end
        rescue => e
          error_msg = "Error renewing token for #{qbo_account.id}: #{e.message}"
          logger.error error_msg
          p "Error renewing token for #{qbo_account.name}: #{e.message}"
        end
      end
    end
  end
end
