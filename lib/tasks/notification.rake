namespace :notification do
  desc "Sends SMS notification to employees asking them to log if they had overtime or not"
  task sms: :environment do
    puts "I'm in a rake task!"
  end

  desc "Sends mail notification to managers (admin users) each day to inform of pending overtime requests"
  task manager_email: :environment do
    submitted_posts = Post.submitted
    admin_user = AdminUser.all

    if submitted_posts.count > 0
      admin_user.each do |admin|
        ManagerMailer.email(admin.email).deliver_later
      end
    end
  end
end
