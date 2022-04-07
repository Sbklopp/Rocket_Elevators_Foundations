require 'aws-sdk'  # In v2: require 'aws-sdk'

class PollyController < ActionController::Base
    # helper_method :speak
    def speak
#  binding.pry
        # user= current_user.find
        customers = Customer.count
        quotes = Quote.count
        leads = Lead.count
        batteries = Battery.count
        elevators = Elevator.count
        inactive_elevators = Elevator.where(status:'Not Running').count
        buildings = Building.count
        cities = Address.distinct.count(:city)
        
        # binding.pry
        #Deleting the file before we recreate it to keep it up-to-date with the current info
        text_file = "#{Rails.root}/app/text_files/myfile.txt"
        if File.file?(text_file)
            File.delete(text_file)
        end

        mp3_file = "#{Rails.root}app/assets/myfile.mp3"
        if File.file?(mp3_file)
            File.delete(mp3_file)
        end

        # open and write the file 
        open(text_file, 'w') do |f|
            f.puts "Hello! Thank you for visiting Rocket Elevators. There are currently #{elevators} elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{inactive_elevators} elevators are inactive and are being serviced. You have #{quotes} quotes awaiting processing. You have #{leads} leads in your contact requests. #{batteries} batteries are deployed across #{cities} cities."
        end

        puts inactive_elevators
        # Get the filename from the command line
        # if ARGV.empty?()
        #     puts 'You must supply a filename'
        #     exit 1
        # end

        # myfile.txt = ARGV[0]

        # Open file and get the contents as a string
        if File.file?(text_file)
            contents = IO.read(text_file)
        else
            puts 'No such file: ' + myfile.txt
            exit 1
        end

        # binding.pry

        # Create an Amazon Polly client using
        # credentials from the shared credentials file ~/.aws/credentials
        # and the configuration (region) from the shared configuration file ~/.aws/config
        polly = Aws::Polly::Client.new(
            access_key_id: ENV['aws_access_key_id'],
            secret_access_key: ENV['aws_secret_access_key']
        )

        resp = polly.synthesize_speech({
            output_format: "mp3",
            text: contents,
            voice_id: "Joanna",
        })

        # Save output
        # Get just the file name
        #  abc/xyz.txt -> xyx.txt
        name = File.basename(text_file)

        # Split up name so we get just the xyz part
        parts = name.split('.')
        myfile = parts[0]
        mp3_file = myfile + '.mp3'

        # binding.pry

        IO.copy_stream(resp.audio_stream, "app/assets/audios/" + mp3_file)

        puts 'Wrote MP3 content to: ' + mp3_file
    rescue Exception => e
        puts 'Got error:'
        puts 'Error message:'
        puts e.message

        render json: e.message
    else 
        redirect_to("/admin/polly")
    end
    helper_method :speak
end

























    # polly = Aws::Polly::Client.new(
    #     access_key_id: ENV['aws_access_key_id'],
    #     secret_access_key: ENV['aws_secret_access_key']
    #     )

    #     resp = client.start_speech_synthesis_task({
    #         engine: "standard", # accepts standard, neural
    #         language_code: "en-US", # accepts arb, cmn-CN, cy-GB, da-DK, de-DE, en-AU, en-GB, en-GB-WLS, en-IN, en-US, es-ES, es-MX, es-US, fr-CA, fr-FR, is-IS, it-IT, ja-JP, hi-IN, ko-KR, nb-NO, nl-NL, pl-PL, pt-BR, pt-PT, ro-RO, ru-RU, sv-SE, tr-TR, en-NZ, en-ZA, ca-ES
    #         # lexicon_names: ["LexiconName"],
    #         output_format: "mp3", # required, accepts json, mp3, ogg_vorbis, pcm
    #         # output_s3_bucket_name: "OutputS3BucketName", # required
    #         # output_s3_key_prefix: "OutputS3KeyPrefix",
    #         sample_rate: "SampleRate",
    #         sns_topic_arn: "SnsTopicArn",
    #         speech_mark_types: ["sentence"], # accepts sentence, ssml, viseme, word
    #         text: "Hello! Thank you for visiting Rocket Elevators. There are currently #{elevators} elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{elevators} elevators are inactive and are being serviced. You have #{quotes} quotes awaiting processing. You have #{leads} leads in your contact requests. #{batteries} batteries are deployed across #{cities} cities.", # required
    #         text_type: "text", # accepts ssml, text
    #         voice_id: "Joanna", # required, accepts Aditi, Amy, Astrid, Bianca, Brian, Camila, Carla, Carmen, Celine, Chantal, Conchita, Cristiano, Dora, Emma, Enrique, Ewa, Filiz, Gabrielle, Geraint, Giorgio, Gwyneth, Hans, Ines, Ivy, Jacek, Jan, Joanna, Joey, Justin, Karl, Kendra, Kevin, Kimberly, Lea, Liv, Lotte, Lucia, Lupe, Mads, Maja, Marlene, Mathieu, Matthew, Maxim, Mia, Miguel, Mizuki, Naja, Nicole, Olivia, Penelope, Raveena, Ricardo, Ruben, Russell, Salli, Seoyeon, Takumi, Tatyana, Vicki, Vitoria, Zeina, Zhiyu, Aria, Ayanda, Arlet
    #       })
        



# Copyright 2010-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# This file is licensed under the Apache License, Version 2.0 (the "License").
# You may not use this file except in compliance with the License. A copy of the
# License is located at
#
# http://aws.amazon.com/apache2.0/
#
# This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS
# OF ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.



        # config.assets.precompile << "audios/*"
        # File.open('greetings.mp3') 
        # do |audio_file|
            # audio_file.write(response)
            # # speaker_model = text_to_speech.create_speaker_model(
            # # speaker_name: "speaker_one",
            # audio: audio_file
            # puts JSON.pretty_generate(speaker_model.result)

            # Get the filename from the command line
        # if ARGV.empty?()
        #     # puts 'greetings.wav'
        #     ARGV << 'greetings.wav'
        #     exit 1
        # end

    # filename = ARGV[0]

    # Open file and get the contents as a string
    # if File.exist?(filename)
    #     contents = IO.read(filename)
    # else
    #     puts 'No such file: ' + filename
    #     exit 1
    # end
 
    # Create an Amazon Polly client using
    # credentials from the shared credentials file ~/.aws/credentials
    # and the configuration (region) from the shared configuration file ~/.aws/config

    # resp = polly.synthesize_speech({
    #     output_format: "mp3",
    #     text: "Hello! Thank you for visiting Rocket Elevators. There are currently #{elevators} elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{elevators} elevators are inactive and are being serviced. You have #{quotes} quotes awaiting processing. You have #{leads} leads in your contact requests. #{batteries} batteries are deployed across #{cities} cities.",
    #     voice_id: "Joanna",
    # })

    # IO.copy_stream(resp.audio_stream, "#{params[:text]}.mp3") 
    #     puts "Params: "
    #     puts params[:text]
    #     send_file "#{params[:text]}.mp3"
    # end
    # # Save output
    # # Get just the file name
    # #  abc/xyz.txt -> xyx.txt
    # name = File.basename(filename)

    # # Split up name so we get just the xyz part
    # parts = name.split('.')
    # first_part = parts[0]
    # wav_file = first_part + '.wav'

    # IO.copy_stream(resp.audio_stream, wav_file)

    #     puts 'Wrote WAV content to: ' + wav_file
    # rescue StandardError => ex
    #     puts 'Got error:'
    #     puts 'Error message:'
    #     puts ex.message

    



#   resp = polly.synthesize_speech({
#     text: "Hello! Thank you for visiting Rocket Elevators. There are currently elevators deployed in the #{buildings} buildings of your #{customers} customers. Currently, #{elevators} elevators are inactive and are being serviced. You have #{quotes} quotes awaiting processing. You have #{leads} leads in your contact requests. #{batteries} batteries are deployed across #{cities} cities.",
#     accept:"audio/mp3",
#     voice_id: "Joanna"

# }).result

