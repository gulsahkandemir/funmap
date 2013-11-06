class Api::FeedsController < ApplicationController
	#include ActionView::Helpers
	skip_before_action :verify_authenticity_token
	def create
		items = params[:items]
		items.each_with_index do |item,i|
			actor = Actor.new(
				:display_name => item[:actor][:displayName], 
				:permalink_url => item[:actor][:permalinkUrl],
				:id_actor => item[:actor][:id]
				) 
			actor.save
			
			feed = Feed.new(
				:id_feed => item[:id], 
				:published => item[:published], 
				:updated => item[:updated], 
				:title => item[:title], 
				:summary => item[:summary], 
				:content => item[:content], 
				:permalink_url => item[:permalinkUrl], 
				:actor => actor 
				)
			feed.save

			categories = item[:categories]
			categories.each do |cat|
				category = Category.find_by(title: cat)
				if category.blank?
					category = Category.new(:title => cat)
					category.save
				end
				feed.categories << category
			end

			respond_to do |format|
			    	format.html
			    	format.xml { render xml: feed }
			    	format.json { render json: feed }
			end		
		end
	end

	def index
		feeds = Feed.all
		respond_to do |format|
	    	format.html
	    	format.xml { render xml: feeds }
	    	format.json { render json: feeds }
	  	end
	end

end