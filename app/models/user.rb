class User < ActiveRecord::Base
  has_many :histories, dependent: :destroy
  require 'phony'
  def convert_to_e164(raw_phone)
    Phony.format(
        raw_phone,
        :format => :international,
        :spaces => ''
    ).gsub(/\s+/, "") # Phony won't remove all spaces
  end
  
  def sendmessage
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    if self.language == "English"
      text_str = Message.find(self.next_message).text
    else
      text_str = SpanishMessage.find(self.next_message).text
    end
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => self.phone,
      :body => text_str,
    )
    puts message.to
    
    #add reminder sent time to history
    note = History.new(:user_id => self.id, :message => "Message ##{self.next_message} sent")
    note.save
    
  end
  def sendlastmessage
    @twilio_number = ENV['TWILIO_NUMBER']
    @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    if self.language == "English"
      text_str = "You have completed the study"
    else
      text_str = "Ha completado el estudio"
    end
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => self.phone,
      :body => text_str,
    )
    puts message.to
    
    #add reminder sent time to history
    note = History.new(:user_id => self.id, :message => "Study completed ")
    note.save
    
    message = @client.account.messages.create(
      :from => @twilio_number,
      :to => ENV['RESEARCHER_PHONE'],
      :body => "Research subject ##{self.id} has completed the study",
    )
  end

  def when_to_run
    time
  end

#   handle_asynchronously :sendmessage
end
