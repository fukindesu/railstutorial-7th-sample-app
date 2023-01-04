User.create!(
  name: 'Example User',
  email: 'example@railstutorial.org',
  password: 'foobar',
  password_confirmation: 'foobar',
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

99.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "example-#{n+1}@railstutorial.org",
    password: 'password',
    password_confirmation: 'password',
    activated: true,
    activated_at: Time.zone.now
  )
end

User.create!(
  name: 'Fukin Desu',
  email: 'fukindesu@gmail.com',
  password: 'Foobar_!',
  password_confirmation: 'Foobar_!',
  activated: true,
  activated_at: Time.zone.now
)

# Generate microposts for some users
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end
