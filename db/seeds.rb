# Only privileged users are created manually.
name = 'Example User'
email = 'example@railstutorial.org'
password = 'password'
password_confirmation = 'password'
User.create!(name:, email:, password:, password_confirmation:)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  password_confirmation = 'password'
  User.create!(name:, email:, password:, password_confirmation:)
end
