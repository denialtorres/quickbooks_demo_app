module OauthActions
  extend ActiveSupport::Concern

  def oauth2_callback
    params[:id] = current_user.account.id

    authenticate_account!

    if params[:state] == session[:oauth2_state]
      client = Qbo::Base.oauth2_client
      client.authorization_code = params[:code]

      if resp = client.access_token!
        current_account.set_oauth2_creds(
          access_token: resp.access_token,
          refresh_token: resp.refresh_token,
          company_id: params[:realmId]
        )
        # InitialImportJob.perform_later(current_account.id, current_user.email)
        @url = qbo_account_accounts_url
        msg = "Your QuickBooks Online account has been successfully connected."
        msg += " We just kicked off a job to pull in your chart of accounts, customers, and items."
        msg += " from QuickBooks. You will receive an email when that process has been completed."
        flash[:notice] = msg
      end
    end

    render html: <<-HTML.html_safe
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <title>Authentication Successful</title>
          <style>
            body {
              font-family: 'Poppins', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
              display: flex;
              justify-content: center;
              align-items: center;
              height: 100vh;
              margin: 0;
              background-color: #faf9f5;
            }
            .message {
              text-align: center;
              color: #141413;
            }
            .spinner {
              border: 4px solid #e8e6dc;
              border-top: 4px solid #2ca01c;
              border-radius: 50%;
              width: 40px;
              height: 40px;
              animation: spin 1s linear infinite;
              margin: 20px auto;
            }
            @keyframes spin {
              0% { transform: rotate(0deg); }
              100% { transform: rotate(360deg); }
            }
          </style>
        </head>
        <body>
          <div class="message">
            <h2>Authentication Successful!</h2>
            <p>Redirecting you to QuickBooks...</p>
            <div class="spinner"></div>
          </div>
          <script>
            // Store the flash message in sessionStorage
            var message = '#{flash[:notice].to_json}';
            sessionStorage.setItem('flash_notice', message);

            // Close popup and redirect parent window
            if (window.opener) {
              // Redirect the parent window to the qbo_account page
              window.opener.location.href = '#{qbo_account_accounts_url}';
              // Close the popup
              window.close();
            } else {
              // If no parent window (not a popup), just redirect
              window.location.href = '#{qbo_account_accounts_url}';
            }
          </script>
        </body>
      </html>
    HTML
  end

  private

  def set_oauth2_state
    session[:oauth2_state] = SecureRandom.hex(16)
  end

  def authenticate_account!
    # Authentication is handled by devise for current_user
  end

  def qbo_account_url(account)
    if account
      qbo_account_accounts_url
    else
      "#"
    end
  end

  def current_account
    @current_account ||= current_user.account
  end
end
