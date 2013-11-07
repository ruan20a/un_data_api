module V1
	class DatasetsController < ApplicationController
		before_filter :authenticate_app

		def index
			organization = Organization.find_by_name(params[:organization])
			datasets = organization.datasets
			
			respond_to do |format|
				format.json { render json: datasets.map { |dataset| dataset.as_json(except: [:id, :country_ids, :organization_id])} }
				format.xml { render xml: datasets.to_xml(except: [:id, :country_ids, :organization_id]) }
			end

		rescue
	  	error(404, 404, "record does not exist")			
		end

		def country_datasets
			organization = Organization.find_by_name(params[:organization])
			country = Country.find_by_name(params[:country])
			datasets = organization.datasets.where(country_ids: country.id).all

			respond_to do |format|
				format.json { render json: datasets.map { |dataset| dataset.as_json(except: [:id, :country_ids, :organization_id])} }
				format.xml { render xml: datasets.to_xml(except: [:id, :country_ids, :organization_id]) }
			end

		end
		
	end
end
