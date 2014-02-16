# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
puts "Cleaning current database (env: #{Rails.env})" if Mongoid.purge!

User.create({ email: 'test@test.pl', password: 'test1234' })
User.create({ email: 'fake@test.pl', password: 'test1234' })