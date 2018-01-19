require 'faker'

10.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Internet.unique.password
  )
end
puts "#{User.count} users created"

20.times do
  Wiki.create!(
    title: Faker::SiliconValley.invention,
    body: Faker::SiliconValley.quote,
    user_id: Faker::Number.between(1,10)
  )
end
wikis = Wiki.all
puts "#{Wiki.count} wikis created"
