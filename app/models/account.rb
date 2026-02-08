class Account < ApplicationRecord
  has_many :users, dependent: :nullify
  has_one :qbo_account, dependent: :destroy

  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true

  # Generate a unique identifier if not provided
  before_validation :generate_identifier, on: :create

  def set_oauth2_creds(args)
    args.merge!(QboAccount.oauth2_expiry_attrs)
    if qbo_account
      qbo_account.update_attributes(args)
    else
      create_qbo_account(args)
    end
  end

  private

  def generate_identifier
    return if identifier.present?

    loop do
      self.identifier = SecureRandom.hex(10)
      break unless Account.exists?(identifier: identifier)
    end
  end
end
