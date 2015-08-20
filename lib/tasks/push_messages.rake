namespace :push_messages do
  desc "move to next message"
  task :pm => :environment do
    # grab all users
    users = User.all
    # send messages to users
    users.each do |u|
      if u.active?
        # reschedule reminders
        u.sendmessage
        u.next_message = u.next_message + 1
        u.save!
        
      end
    end
  end
end