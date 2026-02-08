class CreateAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :identifier

      t.timestamps
    end

    add_index :accounts, :identifier, unique: true
  end
end
