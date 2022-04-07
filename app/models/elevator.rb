class Elevator < ApplicationRecord
    include ActiveModel::Dirty
    belongs_to :column
    has_many :interventions

    after_update :send_sms
    # require 'twilio-ruby'

    private
    def send_sms
        if self.status == "Intervention"
            account_sid = ENV['twilio_account_sid']
            auth_token = ENV['twilio_auth_token']
            client = Twilio::REST::Client.new(account_sid, auth_token)
            
            from = '+12543235637' # Your Twilio number
            to = ENV["Abdul"] # Your mobile phone number
            
            #client.account.sms.message.create
            client.messages.create(
                from: from,
                to: to,
                body: "Elevator moment!"
            )
        end
    end
    oldStatus = ""
    before_update do
        oldStatus = self.status_was
     end
     after_update do
        if oldStatus != self.status
          notifier = Slack::Notifier.new ENV['slack_webhook']
          notifier.ping "The Elevator #{self.id} with Serial Number #{self.serial_number} changed status from #{oldStatus} to #{self.status}"
        end
     end
end
