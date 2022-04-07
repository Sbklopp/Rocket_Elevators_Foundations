    require "ibm_watson"

    require "json"
    require "ibm_watson/authenticators"
    require "ibm_watson/text_to_speech_v1"
    include IBMWatson
    
    # authenticator = Authenticators::IamAuthenticator.new(
    #   apikey: "{apikey}"
    # )
    # text_to_speech = TextToSpeechV1.new(
    #   authenticator: authenticator
    # )
    # text_to_speech.service_url = "{url}"
   
    # user= current_user.find
    # customers = Customer.count
    # quotes = Quote.count
    # leads = Lead.count
    # batteries = Battery.count
    # elevators = Elevator.count
    # inactive_elevators = Elevator.where.not(elevator_status:'active').count
    # buildings = Building.count
    # cities = Address.distinct.count(:city)

    
    
    text_to_speech = IBMWatson::TextToSpeechV1.new(
      authenticator: authenticator
    )
    text_to_speech.service_url = "https://api.us-south.text-to-speech.watson.cloud.ibm.com"
    
    puts JSON.pretty_generate(text_to_speech.list_voices.result)
    
    File.new("greetings.wav", "w+") do |audio_file|
      response = text_to_speech.synthesize(
        text: "Hello #{current_user}! Thank you for visiting Rocket Elevators. There are currently #{Elevators} elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{elevators} elevators are inactive and are being serviced. You have #{quotes} quotes awaiting processing. You have #{leads} leads in your contact requests. #{batteries} batteries are deployed across #{cities} cities.",
        accept: "audio/wav",
        voice: "en-US_OliviaVoice"
      ).result
      audio_file << response
    end
    