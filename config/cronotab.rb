require "rake"

Rails.app_class.load_tasks

class QboRenewTokens
  def perform
    Rake::Task["quickbooks:renew_oauth2_tokens"].reenable
    Rake::Task["quickbooks:renew_oauth2_tokens"].invoke
  end
end

Crono.perform(QboRenewTokens).with_options(truncate_log: 100).every 3.minutes
