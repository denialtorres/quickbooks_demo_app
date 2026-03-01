class QboAccount < ApplicationRecord
  attr_encrypted :access_token, key: Base64.decode64(ENV["ATTR_ENCRYPTED_KEY"])
  attr_encrypted :refresh_token, key: Base64.decode64(ENV["ATTR_ENCRYPTED_KEY"])
  attr_encrypted :company_id, key: Base64.decode64(ENV["ATTR_ENCRYPTED_KEY"])

  attr_accessor :company_id # temporal

  belongs_to :account

  scope :expired, -> { where("reconnect_token_at <= ?", Time.current).where("token_expires_at >= ?", Time.current) }

  def self.oauth2_expiry_attrs
    { token_expires_at: 1.hour.from_now, reconnect_token_at: 50.minutes.from_now }
  end
end
