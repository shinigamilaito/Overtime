@user = User.create(email: "test@test.com",
                    password: "asdfasdf",
                    password_confirmation: "asdfasdf",
                    first_name: "Edgar",
                    last_name: "Espindola",
                    phone: "1415779328")

puts "1 User created"

AdminUser.create(email: "admin@test.com",
                 password: "asdfasdf",
                 password_confirmation: "asdfasdf",
                 first_name: "Admin",
                 last_name: "Name",
                 phone: "1415779328")

puts "1 admin user created"

[6, 13, 20].each do |number_days|
  AuditLog.create!(user: @user,
                   start_date: (Date.today - number_days.days))
end

puts "3 Audit logs have been created"

100.times do |post|
  Post.create!(date: Date.today,
               rationale: "#{post} rationale content",
               user: @user,
               overtime_request: 3.5)
end

puts "100 Posts have been created"

