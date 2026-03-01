class AccountsController < ApplicationController
  before_action :authenticate_user!, except: [ :oauth2_callback ]
  include OauthActions

  def index
    @user = current_user
    @account = @user&.account
  end

  def qbo_account
    set_oauth2_state
    @redirect_uri = Qbo::Base.oauth2_client.authorization_uri(scope: "com.intuit.quickbooks.accounting",
      state: session[:oauth2_state])
    @qbo_account = current_account.qbo_account || current_account.build_qbo_account
    # @form = QboAccountForm.new(@qbo_account)
    if request.patch?
      @form.submit(qbo_account_params)
    end
    # @items = current_account.items
  end

  def disconnect
    current_account.qbo_account.clear
    url = qbo_account_url(current_account)
    redirect_to url, notice: "Successfully disconnected from Quickbooks", turbolinks: false
  rescue => e
    url = qbo_account_url(current_account)
    redirect_to url, alert: "There was a problem disconnecting from Quickbooks. try again",  turbolinks: false
  end

  private

  # The session[:oauth2_state] is used to protect against a CSRF. When testing use a static uuid and not a random one.”
  def set_oauth2_state
    session[:oauth2_state] = SecureRandom.hex(16)
  end

  def current_account
    @current_account ||= current_user.account
  end
end
