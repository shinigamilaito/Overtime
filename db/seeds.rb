@user = User.create(email: "test@test.com", password: "asdfasdf", password_confirmation: "asdfasdf", first_name: "Edgar", last_name: "Espindola")

puts "1 User created"

100.times do |post|
  Post.create!(date: Date.today, rationale: "#{post} rationale content", user: @user)
end

puts "100 Posts have been created"
