module V1
	class OrganizationsController < ApplicationController

		def index
			organizations = Organization.all

      organizations.map! {|organization| organization.serializable_hash(except: [:id, :country_ids]) }
			respond_with(organizations)

		rescue
			error(404, 404, "record does not exist")	
		end
		
	end
end
