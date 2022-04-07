require "freshdesk"
        
#Create a ticket with cc_emails attributes.
# require 'rubygems'
# require 'rest_client'
require 'json'


class LeadsController < ApplicationController
    skip_before_action :verify_authenticity_token
    invisible_captcha only: :index, honeypot: :subtitle

    def create
        @lead = Lead.create!(
            contact_name: params[:contact_name],
            company_name: params[:company_name],
            email: params[:email],
            phone: params[:phone],
            project_name: params[:project_name],
            project_description: params[:project_description],
            department: params[:department],
            message: params[:message],
            attached_file: image?,
            filename: image_name?
        )
    # end

    # def new
        # @lead = Lead.new

        # freshdesk_api_url 
        api_key = ENV['FRESHDESK_API']


        # Your freshdesk domain
        # freshdesk_domain = 'rocketelevators.freshdesk.com/helpdesk/tickets'
        freshdesk_domain = 'rocketelevators-helpdesk'

        # It could be either your user name or api_key.
        # api_key: ENV['FRESHDESK_API']

        # If you have given api_key, then it should be x. If you have given user name, it should be password
        if @lead.contact_name == nil
        @lead.contact_name = "n/a"
        end
        if @lead.company_name == nil
        @lead.company_name = "n/a"
        end
        if @lead.email == nil
        @lead.email = "n/a"
        end
        if @lead.phone == nil
        @lead.phone = "n/a"
        end
        if @lead.project_name == nil
        @lead.project_name = "n/a"
        end
        if @lead.project_description == nil
        @lead.project_description = "n/a"
        end
        if @lead.department == nil
        @lead.department = "n/a"
        end
        if @lead.message == nil
        @lead.message = "n/a"
        end
        if @lead.attached_file == nil
        @lead.attached_file = "n/a"
        has_attachment = "not"  
        else
        has_attachment = ""
        end

        json_payload = {
            status: 2,  
            priority: 1, 
            "name": @lead.contact_name, 
            "phone": @lead.phone,
            "email": @lead.email,
            "description": 
            "The contact " + @lead.contact_name + " from company " + @lead.company_name + " can be reached at email " + @lead.email + " and at phone number  " + @lead.phone + ". " + @lead.department + " has a project named " + @lead.project_name + ". which would require contribution from Rocket Elevators. " + @lead.project_description + ". Attached Message: " + @lead.message + ". The Contact uploaded an attachment.",
            "type": "Question",
            "subject": @lead.contact_name + " from " + @lead.company_name,
        }.to_json

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

        redirect_to('/index')
    end

    private 

    def image?
        params[:attached_file].read if params[:attached_file]
    end
    def image_name?
        params[:attached_file].original_filename if params[:attached_file]
    end
end
