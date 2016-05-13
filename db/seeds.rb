# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all

users = []
posts = []

10.times do
	
	users << User.create(password: '1', username: Faker::Internet.user_name, email: Faker::Internet.email)

end

users.each do |user|

	3.times do
		posts << Post.create(user_id: user.id, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
	end

end

posts.each do |post|

	3.times do
		Comment.create(user_id: users.sample.id, post_id: post.id, combody: Faker::Lorem.sentence)
	end

end