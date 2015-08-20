class User < ActiveRecord::Base
  has_many :histories
  
  def sendmessage
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    time_str = ((self.time).localtime).strftime("%I:%M%p")
    text_str = Message.find(self.next_message)
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => self.phone,
      :body => text_str,
    )
    puts message.to
    
    #add reminder sent time to history
    note = History.new(:user_id => self.id, :message => "Message ##{self.next_message} sent", :time => DateTime.now, :category => "info")
    note.save
    
  end

  def when_to_run
    time
  end

  handle_asynchronously :sendmessage, :run_at => Proc.new { |i| i.when_to_run }
end