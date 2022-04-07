class Lead < ApplicationRecord
    # after_create :send_email1
    # def send_email1
    #     send_email(self)
    # end
    # using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
# require 'sendgrid-ruby'
# include SendGrid

# def send_email(lead)
#     sg = SendGrid::API.new(api_key: ENV['SGAPIKEY'])
   
#     mail = Mail.new
#     mail.template_id = 'd-5c424c14635743068724cf1568bf5372'
#     personalization0 = Personalization.new
#     personalization0.add_to(Email.new(email: "#{lead.email}", name: "#{lead.contact_name}"))
    # , project: "#{lead.project_name}"
    # mail.add_personalization(personalization0)

    # mail.from = Email.new(email: 'rocketelevatorsgo@gmail.com')
    # mail.reply_to = Email.new(email: "#{lead.email}")
    # mail.subject = 'Thankyou for your submission' #<======================

#     email_content = "<p>Greetings #{lead.contact_name}.</p>
#     We thank you for contacting Rocket Elevators to discuss the opportunity 
#     to contribute to your project #{lead.project_name}. A representative from our 
#     team will be in touch with you very soon. We look forward to demonstrating 
#     the value of our solutions and helping you choose the appropriate product 
#     given your requirements.
#     We’ll Talk soon
#     The Rocket Team"

#     mail.add_content(Content.new(type: 'text/html', value: email_content))
    
#     response = sg.client.mail._('send').post(request_body: mail.to_json)
    
#     puts "#############################################################"
#     puts response.status_code
#     puts response.body
#     puts response.headers
#     puts "email sent"
# end
end