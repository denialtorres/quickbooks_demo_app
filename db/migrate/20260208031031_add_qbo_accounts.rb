class AddQboAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :qbo_accounts, force: :cascade do |t|
      t.string :encrypted_access_token
      t.string :encrypted_access_token_iv
      t.string :encrypted_refresh_token
      t.string :encrypted_refresh_token_iv
      t.string :encrypted_companyid
      t.string :encrypted_companyid_iv
      t.integer :account_id
      t.datetime :token_expires_at
      t.datetime :reconnect_token_at
      t.integer :default_labor

      t.timestamps
    end
  end
end
