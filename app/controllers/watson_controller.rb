# require "ibm_watson/authenticators"
# require "ibm_watson/text_to_speech_v1"
# include IBMWatson

# class WatsonController < ActionController::Base
#     def speak
#         authenticator = Authenticators::IamAuthenticator.new(
#             apikey: "BhzrVOQT5mHv5Yu5ecvQAavp9sXTvQlBFAfc4TTz9TNj"
#         )
#         text_to_speech = TextToSpeechV1.new(
#             authenticator: authenticator
#         )
            
#         text_to_speech.service_url = "https://api.us-south.text-to-speech.watson.cloud.ibm.com/instances/f2340b52-4ca3-4a15-9842-d179f07b1a71"
#         # text_to_speech.service_url = "https://api.us-south.text-to-speech.watson.cloud.ibm.com/instances/f2340b52-4ca3-4a15-9842-d179f07b1a71"
    
#         # user= current_user.find
#         customers = Customer.count
#         quotes = Quote.count
#         leads = Lead.count
#         batteries = Battery.count
#         elevators = Elevator.count
#         # inactive_elevators = Elevator.status(elevator_status:'active').count
#         buildings = Building.count
#         cities = Address.distinct.count(:city)
    
#         response = text_to_speech.synthesize(
#             text: "Hello! Thank you for visiting Rocket Elevators. There are currently elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{elevators} elevators are inactive and are being serviced. You have #{quotes} quotes awaiting processing. You have #{leads} leads in your contact requests. #{batteries} batteries are deployed across #{cities} cities.",
#             accept:"audio/wav",
#             voice: "en-US_OliviaV3Voice"
    
#         ).result
    
#         File.open("greetings.wav", "wb") do |audio_file|
#             audio_file.write(response)
#             # speaker_model = text_to_speech.create_speaker_model(
#             # speaker_name: "speaker_one",
#             # audio: audio_file
#             # puts JSON.pretty_generate(speaker_model.result)
#         end
#     end
# end





























