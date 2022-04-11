# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# %w[fastest slowest db app ballancer rabbitmq sidekiq cache_db].each do
#   |tag_name| Tag.create(name: tag_name) 
# end

# 10.times do |time|
#   User.create(
#     first_name: "First_#{time}",
#     last_name: "Last_#{time}",
#     balance: rand(10000)
#   )
# end

# users = User.all
# tags = Tag.all

# 100_000.times do |time|
#     Order.create(
#       name: "vm-#{time}",
#       cost: rand(10000),
#       status: rand(5),
#       user: users.shuffle.first
#       # tags: tags.shuffle.take(rand(5))
#  )
#  end

# vm_names = %w[linux-best windows-10 windows-11] 
# project_names = %w[cool-server internship ruby-hello-world] 
# project_states = %w[started development production] 
# hdd_types = %w[sata sas ssd] 

# vm_names.each do |vm_n|
#   Vm.create(
#     name: vm_n,
#     cpu: 2 ** rand(4),
#     ram: 2 ** (rand(4) + 1)
#   )
# end

# vms = Vm.all

# project_names.each do |project_n|
#   Project.create(
#     name: project_n,
#     state: project_states.shuffle.first,
#     vms: vms.shuffle.take(rand(2) + 1)
#   )
# end

# hdd_types.each do |hdd_t| 
#   10.times do |i|
#     Hdd.create(
#       hdd_type: hdd_t,
#       size: rand(90) + 10,
#       vm: vms.shuffle.first
#     )
#   end
# end

# 10.times do |i|
#   Group.create(name: "name_#{i}")
# end