# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name:"Chester", email:"chesterajohn@gmail.com",password:"111222333",password_confirmation:"111222333", admin:true)

50.times do |x|
	name = Faker::Name.name
	email = "example-#{x + 1}@wtf.com"
	password = "password"

	User.create(name: name,email: email, password: password, password_confirmation: password)

end