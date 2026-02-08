class SessionsController < Devise::SessionsController
  include Devise::Controllers::Rememberable
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) && resource_or_scope.account.present?
      accounts_index_path  # Users with accounts → dashboard
    else
      root_path  # Users without accounts (like admin@example.com) → home
    end
  end
end
