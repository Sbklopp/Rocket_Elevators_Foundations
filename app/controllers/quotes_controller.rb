require "freshdesk"
require 'json'

class QuotesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
      @quote = Quote.create!(
          department: params[:department],
          number_of_floors: params[:number_of_floors],
          number_of_companies: params[:number_of_companies],
          number_of_basements: params[:number_of_basements],
          number_of_parking_spots: params[:number_of_parking_spots],
          number_of_elevators: params[:number_of_elevators],
          number_of_corporations: params[:number_of_corporations],
          maximum_occupancy: params[:maximum_occupancy],
          number_of_apartments: params[:number_of_apartments],
          business_hours: params[:business_hours],
          service_grade: params[:service_grade],
          elevator_amount: params[:elevator_amount],
          elevator_unit_price: params[:elevator_unit_price], 
          elevator_total_price: params[:elevator_total_price],
          installation_fees: params[:installation_fees],
          final_price: params[:final_price],
          contact_name: params[:contact_name],
          company_name: params[:company_name],
          contact_email: params[:contact_email]     
    )
    # binding.pry
    # Your freshdesk domain
        # freshdesk_domain = 'rocketelevators.freshdesk.com/helpdesk/tickets'
            freshdesk_domain = 'rocketelevators-helpdesk'

            # It could be either your user name or api_key.
            api_key = ENV['FRESHDESK_API']

              if @quote.department == nil
              @quote.department = "n/a"
              end
              if @quote.number_of_floors == nil
              @quote.number_of_floors = "n/a"
              end
              if @quote.number_of_companies == nil
              @quote.number_of_companies = "n/a"
              end
              if @quote.number_of_basements == nil
              @quote.number_of_basements = "n/a"
              end
              if @quote.number_of_parking_spots == nil
              @quote.number_of_parking_spots = "n/a"
              end
              if @quote.number_of_elevators == nil
              @quote.number_of_elevators = "n/a"
              end
              if @quote.number_of_corporations == nil
              @quote.number_of_corporations = "n/a"
              end
              if @quote.maximum_occupancy == nil
              @quote.maximum_occupancy = "n/a"
              end
              if @quote.number_of_apartments == nil
              @quote.number_of_apartments = "n/a"
              end
              if @quote.business_hours == nil
              @quote.business_hours = "n/a"
              end
              if @quote.service_grade == nil
              @quote.service_grade = "n/a"
              end
              if @quote.elevator_amount == nil
              @quote.elevator_amount = "n/a"
              end
              if @quote.elevator_unit_price == nil
              @quote.elevator_unit_price = "n/a"
              end
              if @quote.elevator_total_price == nil
              @quote.elevator_total_price = "n/a"
              end
              if @quote.installation_fees == nil
              @quote.installation_fees = "n/a"
              end
              if @quote.final_price == nil
              @quote.final_price = "n/a"
              end
              if @quote.contact_name == nil
              @quote.contact_name = "n/a"
              end
              if @quote.company_name == nil
              @quote.company_name = "n/a"
              end
              if @quote.contact_email == nil
              @quote.contact_email = "n/a"
              end


              json_payload = {
                status: 2,  
                priority: 1, 
                "name": @quote.contact_name, 
                "email": @quote.contact_email,
                "description": 
                "The contact " + @quote.contact_name + " from company " + @quote.company_name + " can be reached at email " + @quote.contact_email + ". The building type selected is " + @quote.department + ", and the service grade is " + @quote.service_grade + ". The amount of elevators is " + @quote.elevator_amount + ". The total for installation fees is " + @quote.installation_fees + ", with the grand total price as " + @quote.final_price,
                "type": "Feature Request",
                "subject": @quote.contact_name + " from " + @quote.company_name,
            }.to_json


        #   json_payload = {
        #       status: 2,  
        #       priority: 1, 
        #       "name": @quote.contact_name,
        #       "company": @quote.company_name,
        #       "email": @quote.contact_email,
        #       "description": "The contact " + @quote.contact_name + "can be reached at " + @quote.contact_email + ". The Building type selected is: " + @quote.department  + ". The service grade is: " + @quote.service_grade + ", and the amount of elevators is " + @quote.number_of_elevators + ". Sub total for the installation fees " + @quote.installation_fees + ". Total price is " + @quote.final_price,
        #       "subject": @quote.contact_name + " from " + @quote.company_name
        #   }.to_json

        freshdesk_api_path = 'api/v2/tickets'

        freshdesk_api_url  = "https://#{freshdesk_domain}.freshdesk.com/#{freshdesk_api_path}"

        site = RestClient::Resource.new(freshdesk_api_url, api_key)

        begin
            response = site.post(json_payload, :content_type=>'application/json')
            puts "response_code: #{response.code} \n Location Header: #{response.headers[:location]}\n response_body: #{response.body}"
        rescue RestClient::Exception => exception
            puts 'API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id'
            puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
            puts "Response Code: #{exception.response.code} Response Body: #{exception.response.body} "
        end

        redirect_to('/quote')
    end
end
