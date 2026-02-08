class Account < ApplicationRecord
  has_many :users, dependent: :nullify

  validates :name, presence: true
  validates :identifier, presence: true, uniqueness: true

  # Generate a unique identifier if not provided
  before_validation :generate_identifier, on: :create

  private

  def generate_identifier
    return if identifier.present?

    loop do
      self.identifier = SecureRandom.hex(10)
      break unless Account.exists?(identifier: identifier)
    end
  end
end
