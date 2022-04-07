require 'twilio-ruby'

account_sid = ENV['twilio_account_sid']
auth_token = ENV['twilio_auth_token']
client = Twilio::REST::Client.new(account_sid, auth_token)

from = '+12543235637' # Your Twilio number
to = '+17276993228' # Your mobile phone number

client.messages.create(
from: from,
to: to,
body: "Elevator moment!"
)