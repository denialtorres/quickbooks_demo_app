# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the db with db:setup).

# Example:
#   Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])

# Create sample accounts
account1 = Account.find_or_create_by!(identifier: 'demo_account_1') do |account|
  account.name = "Acme Corporation"
end

account2 = Account.find_or_create_by!(identifier: 'demo_account_2') do |account|
  account.name = "Globex Industries"
end

account3 = Account.find_or_create_by!(identifier: 'demo_account_3') do |account|
  account.name = "Soylent Corp"
end

puts "Created #{Account.count} accounts"

# Create sample users for each account
user1 = User.find_or_create_by!(email: 'john@acme.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.account = account1
end

user2 = User.find_or_create_by!(email: 'jane@acme.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.account = account1
end

user3 = User.find_or_create_by!(email: 'bob@globex.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.account = account2
end

user4 = User.find_or_create_by!(email: 'alice@globex.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.account = account2
end

user5 = User.find_or_create_by!(email: 'charlie@soylent.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.account = account3
end

user6 = User.find_or_create_by!(email: 'diane@soylent.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.account = account3
end

puts "Created #{User.count} users"
puts "Seeding complete!"
