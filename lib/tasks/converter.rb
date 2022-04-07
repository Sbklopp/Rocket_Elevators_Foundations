require 'pg'
require 'mysql2'


FactQuote.delete_all
FactElevator.delete_all
FactContact.delete_all
DimCustomer.delete_all
FactIntervention.delete_all




def move_quote
    Quote.all.each do |q|
    FactQuote.create!(
            {
                quoteid: q.id,
                creation: q.date_created,
                company_name: q.company_name,
                email: q.contact_email,
                nbelevator: q.elevator_amount
            }
        )
    end
end
move_quote()
puts "=== FactQuote imported ==="
def move_contacts
    Lead.all.each do |l|
    FactContact.create!(
        {
            contactid: l.id,
            creation_date: l.contact_request_date,
            company_name: l.company_name,
            email: l.email,
            project_name: l.project_name,
        }
    )
    end
end
move_contacts()
puts "=== FactContact imported ==="
def move_customers
    Customer.all.each do |c|
        elevator_number = 0
        c.buildings.all.each do |building|
            building.batteries.all.each do |battery|
                battery.columns.all.each do |column|
                    elevator_number += column.elevators.count
                end
            end
        end
        DimCustomer.create!(
            {
                creation_date: c.creation_date,
                company_name: c.company_name,
                main_contact_name: c.company_contact_name,
                main_contact_email: c.company_contact_email,
                num_of_elevators: elevator_number,
                customer_city: c.address.city
            }
        )
    end
end
move_customers()
puts "=== DimCustomer imported ==="
def move_elevators
    Elevator.all.each do |e|
        # binding.pry
        FactElevator.create!(
            {
                serial_num: e.serial_number,
                date_of_commision: e.commission_date,
                building_id: Battery.find(Column.find(e.column_id).battery_id).building_id,
                customer_id: Building.find(Battery.find(Column.find(e.column.id).battery_id).building_id).customer_id,
                building_city: Address.find(Building.find(Battery.find(Column.find(e.column.id).battery_id).building_id).address_id).city,
            }
        )
    end
end
move_elevators()
puts "=== FactElevator imported ==="

def move_interventions
    Battery.all.each do |battery|
        
        if battery.status == "Intervention"
            startdate = Faker::Date.between(from: (battery.commission_date), to: Date.today)
            case rand(1..10)
            when 1..9 then enddate = nil 
            when 10 then enddate = Faker::Date.between(from:startdate, to: Date.today)
            end
            
            if enddate == nil 
                result = "Incomplete"
                status = ["Pending", "InProgress", "Interrupted","Resumed"].sample
            else 
                result = ["Success", "Failure"].sample
                Battery.find(battery.id).status = "Running"
                status = "Complete"
            end      
            
            FactIntervention.create!(
                {
                    employee_id: battery.employee_id,
                    building_id: battery.building_id,
                    battery_id: battery.id,
                    column_id:  nil,
                    elevator_id: nil,
                    startdate: startdate,
                    enddate: enddate,
                    result: result,
                    report: Faker::Lorem.paragraph,
                    status: status,
                }
            )
        end
    end


    Column.all.each do |column|
        
        if column.status == "Intervention"
            startdate = Faker::Date.between(from: (Battery.find(column.battery_id).commission_date), to: Date.today)
            case rand(1..10)
            when 1..9 then enddate = nil 
            when 10 then enddate = Faker::Date.between(from:startdate, to: Date.today)
            end
            
            if enddate == nil 
                result = "Incomplete"
                status = ["Pending", "InProgress", "Interrupted","Resumed"].sample
            else 
                result = ["Success", "Failure"].sample
                Column.find(column.id).status = "Running"
                status = "Complete"
                # binding.pry
            end      
            
            FactIntervention.create!(
                {
                    employee_id: Battery.find(column.battery_id).employee_id,
                    building_id: Battery.find(column.battery_id).building_id,
                    battery_id: nil,
                    column_id: column.id,
                    elevator_id: nil,
                    startdate: startdate,
                    enddate: enddate,
                    result: result,
                    report: Faker::Lorem.paragraph,
                    status: status,
                }
            )
        end
    end
    Elevator.all.each do |elevator|
        
        if elevator.status == "Intervention"
            startdate = Faker::Date.between(from: (elevator.commission_date), to: Date.today)
            case rand(1..10)
            when 1..9 then enddate = nil 
            when 10 then enddate = Faker::Date.between(from:startdate, to: Date.today)
            end
            
            if enddate == nil 
                result = "Incomplete"
                status = ["Pending", "InProgress", "Interrupted","Resumed"].sample
            else 
                result = ["Success", "Failure"].sample
                Elevator.find(elevator.id).status = "Running"
                status = "Complete"
            end      
            
            FactIntervention.create!(
                {
                    employee_id: Battery.find(Column.find(elevator.column_id).battery_id).employee_id,
                    building_id: Battery.find(Column.find(elevator.column_id).battery_id).building_id,
                    battery_id: nil,
                    column_id:  nil,
                    elevator_id: elevator.id,
                    startdate: startdate,
                    enddate: enddate,
                    result: result,
                    report: Faker::Lorem.paragraph,
                    status: status,
                }
            )
        end
    end
end
move_interventions()
puts "=== FactInterventions imported ==="