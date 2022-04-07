class Customer < ApplicationRecord
    has_many :buildings
    belongs_to :address 
    belongs_to :user
    has_many :interventions
    #when new customer is created
    after_create :upload_files
    require 'dropbox_api'
        
    def upload_files
        # A random person would come to the site and fill out the contact form, thus creating a lead
        # This "lead" would then be turned into a customer (ie. In the back office, in your Customers table, a new customer entry would be added using the same email as the lead)

        client = DropboxApi::Client.new(ENV["RocketElevatorsFiles"])
        #find a lead with a matching customer email
        lead = Lead.find_by_email(self.company_contact_email)

        #if lead exists
        if lead
            #if lead email matches a customer email
            if lead.email == self.company_contact_email
                begin
                    client.create_folder("/#{lead.contact_name}")
                rescue DropboxApi::Errors::FolderConflictError
                    puts "Customer already has pre-existing Dropbox folder"
                end
                begin
                    client.upload("/" + lead.contact_name + "/" + lead.filename, lead.attached_file)
                rescue DropboxApi::Errors::FileConflictError
                    puts "File already exists."
                end 
                #upload               
                puts "#############################"
            end 
        end
    end
end # End Customer

# path = "/" + self.full_name_of_company_contact
# dropbox_client.upload(path + "/" + lead.file_name, lead.attachment)