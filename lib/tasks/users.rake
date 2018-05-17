namespace :users do
  desc "Invite User after Creating them"
  task invite_users: :environment do
    User.find_each do |user|
      if user.join_date == Date.today
        user.send_reset_password_instructions
      end
    end
  end
end
