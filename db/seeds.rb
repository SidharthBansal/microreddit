User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activation: true,
             activated_at: Time.zone.now)


99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activation: true,
               activated_at: Time.zone.now)

end
users = User.order(:created_at).take(8)
50.times do
  title = Faker::Lorem.words(rand(2..3)).join(" ")
  description = Faker::Lorem.sentence(9)
  users.each { |user| user.posts.create!(title: title, description: description) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
