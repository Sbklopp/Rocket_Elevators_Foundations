# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
include SendGrid

def send_email(lead)
    from = Email.new(email: 'gorocketelevators@gmail.com')
    to = Email.new(email: "#{lead.email}")
    subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: "Greetings #{lead.contact_name} 
    We thank you for contacting Rocket Elevators to discuss the opportunity 
    to contribute to your project #{lead.project_name}. A representative from our 
    team will be in touch with you very soon. We look forward to demonstrating 
    the value of our solutions and helping you choose the appropriate product 
    given your requirements.
    We’ll Talk soon
    The Rocket Team")
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
    puts "wow"
end