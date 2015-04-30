# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
30.times do
  user = User.new
  user.email = Faker::Internet.email
  user.password = "helloworld"
  user.save!
  10.times do
    wiki = Wiki.new
    wiki.title = Faker::Lorem.sentence(1)
    wiki.body = Faker::Lorem.paragraph(1)
    wiki.user_id = user.id
    wiki.save!
  end
end
user = User.all

user = User.new
user.email = "admin@example.com"
user.password = "helloworld"
user.role = "admin"
user.save!


puts "#{User.all.count} users created"
puts "#{Wiki.all.count} wikis created"