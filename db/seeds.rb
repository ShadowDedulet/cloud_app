# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

%w[fastest slowest db app ballancer rabbitmq sidekiq cache_db].each do
  |tag_name| Tag.create(name: tag_name) 
end

10.times do |time|
  User.create(
    first_name: "First_#{time}",
    last_name: "Last_#{time}",
    balance: rand(10000)
  )
end

users = User.all
tags = Tag.all

100_000.times do |time|
    Order.create(
      name: "vm-#{time}",
      cost: rand(10000),
      status: rand(5),
      user: users.shuffle.first
      # tags: tags.shuffle.take(rand(5))
 )
 end
 