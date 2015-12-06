# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

company1 = Company.create!(name: Faker::Company.name, zip_code: Faker::Address.zip_code)

5.times do 
	CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: true, refunded: false, company_id: company1.id)
end

company2 = Company.create!(name: Faker::Company.name, zip_code: Faker::Address.zip_code)

3.times do 
	CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: true, refunded: false, company_id: company2.id)
end

CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: true, refunded: true, company_id: company2.id)

CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: false, refunded: false, company_id: company2.id)

5.times do 
	curr_user = User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
	CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: true, refunded: false, user_id: curr_user.id)
end

first_user = User.first
2.times do 
	CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: true, refunded: true, user_id: first_user.id)
end
CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: false, refunded: false, user_id: first_user.id)

last_user = User.last
3.times do 
	CreditCardCharge.create!(amount: Faker::Commerce.price, unique_code: Faker::Code.isbn, paid: false, refunded: false, user_id: last_user.id)
end