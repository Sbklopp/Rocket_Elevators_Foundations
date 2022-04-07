require "freshdesk"
require 'json'

class InterventionsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def create 
    @intervention = Intervention.create!(
      author: Employee.find(current_user.id),
      customer_id: params[:customer],
      building_id: params[:building],
      battery_id: params[:battery],
      column_id: params[:column],
      elevator_id: params[:elevator],
      report: params[:report],
      employee_id: params[:employee]
    )
    
    api_key = ENV['FRESHDESK_API']

    # Your freshdesk domain
    # freshdesk_domain = 'rocketelevators.freshdesk.com/helpdesk/tickets'
    freshdesk_domain = 'rocketelevators-helpdesk'

    if @intervention.author_id == nil
      @intervention.author_id = "n/a"
    end

    if @intervention.customer_id == nil
      @intervention.customer_id = "n/a"
    end

    if @intervention.building_id == nil
      @intervention.building_id = "n/a"
    end

    if @intervention.battery_id == nil
      @intervention.battery_id = "n/a"
    end    

    if @intervention.column_id == nil
      @intervention.column_id = "n/a"
    end

    if @intervention.elevator_id == nil
      @intervention.elevator_id = "n/a"
    end

    if @intervention.report == nil
      @intervention.report = "n/a"
    end

    if @intervention.employee_id == nil
      @intervention.employee_id = "n/a"
    end

    json_payload = {         
        status: 2,                
        priority: 1,              
        "email": "sbklopp11@rocketelevators.freshdesk.com",               
        "description":               
        "A new intervention has been submitted by employee " + @intervention.author.to_s,             
        "type": "Incident",             
        "subject": @intervention.report, 
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

    redirect_back(fallback_location: root_path)
    # redirect_to('/')
    puts "======================"
  end

      # get building by customer
      def get_buildings_by_customer
        @buildings = Building.where("customer_id = ?", params[:customer_id]) 
        # params[:customer] <----- might be this one?

        respond_to do |format|
          format.json { render :json => @buildings }
        end
      end

      def building_search
        if params[:customer_id].present? && params[:customer_id].strip != ""
          @buildings = Building.where("customer_id = ?", params[:customer_id])
        else
          @buildings = Building.all
        end
      end


         # get batteries by building 
      def get_batteries_by_building
        @batteries = Battery.where("building_id = ?", params[:building_id])
    
        respond_to do |format|
          format.json { render :json => @batteries }
        end
      end

      def battery_search
        if params[:building_id].present? && params[:building_id].strip != ""
          @batteries = Battery.where("building_id = ?", params[:building_id])
        else
          @batteries = Battery.all
        end
      end


      #get columns by battery
    
      def get_columns_by_batteries
        @columns = Column.where("battery_id = ?", params[:battery_id])
    
        respond_to do |format|
          format.json { render :json => @columns }
        end
      end

      def column_search
        if params[:battery_id].present? && params[:battery_id].strip != ""
          @columns = Column.where("battery_id = ?", params[:battery_id])
        else
          @columns = Column.all
        end
      end



      # get elevators by column
    
      def get_elevators_by_columns
        @elevators = Elevator.where("column_id = ?", params[:column_id])
    
        respond_to do |format|
          format.json { render :json => @elevators }
        end
      end

      def elevator_search
        if params[:column_id].present? && params[:column_id].strip != ""
          @elevators = Elevator.where("column_id = ?", params[:column_id])
        else
          @elevators = Elevator.all
        end
      end


      
    
end