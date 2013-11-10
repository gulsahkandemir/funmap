require 'open-uri'
class Api::Subscriptions::SfFunCheapController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		items = params[:items]
		items.each_with_index do |item,i|


			# Start crawling through website of the feed and get the address
			page = Nokogiri::HTML(open(item[:id]))

			text_stats = page.css('#stats').text
			map_data_regex = /<!\[CDATA\[\s*\*\/var\s+mapdata\s*=(.*?\})\s*\;/
			map_data_json = text_stats.match(map_data_regex)[1]

			map_data = ActiveSupport::JSON.decode(map_data_json)
			location_data = map_data["pois"].first
			point = location_data["point"]
			latitude = point["lat"]
			longitude = point["lng"]
			corrected_address = location_data["correctedAddress"]

			# Parse date of the event from item[:title]
			date = Date.parse(item[:title])

			# Check for a duplicate actor first
			actor = Actor.find_by(id_actor: item[:actor][:id])
			if actor.blank?
				actor = Actor.new(
					:display_name => item[:actor][:displayName], 
					:permalink_url => item[:actor][:permalinkUrl],
					:id_actor => item[:actor][:id]
					) 
				actor.save
			end

			# Check for a duplicate feed first
			feed = Feed.find_by(id_feed: item[:id])
			if feed.blank?
				feed = Feed.new(
					:id_feed => item[:id],  
					:title => item[:title], 
					:summary => item[:summary], 
					:content => item[:content], 
					:permalink_url => item[:permalinkUrl], 
					:latitude => latitude,
					:longitude => longitude,
					:address => corrected_address,
					:date => date,
					:actor => actor
					)
				feed.save
			end

			categories = item[:categories]
			categories.each do |cat|
				category = Category.find_by(title: cat)
				if category.blank?
					category = Category.new(:title => cat)
					category.save
				end
				feed.categories << category unless feed.categories.include?(category)
			end

			respond_to do |format|
			    	format.html
			    	format.xml { render xml: feed }
			    	format.json { render json: feed }
			end		
		end
	end

	def index
		render :text => params["hub.challenge"]
	end

end