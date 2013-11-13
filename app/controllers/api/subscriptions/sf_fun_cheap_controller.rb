require 'open-uri'
class Api::Subscriptions::SfFunCheapController < ApplicationController
	skip_before_action :verify_authenticity_token
	def create
		logger.info "=========START=========="
		logger.info request.env
		logger.info "==========END==========="

		items = params[:items]
		begin
			items.each_with_index do |item,i|

				begin
					# Start crawling through website of the feed and get the address
					page = Nokogiri::HTML(open(item[:id]))

					text_stats = page.css('#stats').text
					map_data_regex = /<!\[CDATA\[\s*\*\/var\s+mapdata\s*=(.*?\})\s*\;/
					map_data_regex_result = text_stats.match(map_data_regex)
					#if text_stats includes a CDATA block, parse location
					if !map_data_regex_result.nil?
						map_data_json = map_data_regex_result[1]
						map_data = ActiveSupport::JSON.decode(map_data_json)
						location_data = map_data["pois"].first
						point = location_data["point"]
						latitude = point["lat"]
						longitude = point["lng"]
						corrected_address = location_data["correctedAddress"]
					end

					# Get feed item's image url
					img_entries = page.css(".entry img")
					img_src = ""
					if img_entries.count > 0
						img_src = img_entries[0].attr("src")	
					end

					# Parse date of the event from item[:title]
					date = Date.strptime(item[:title], "%m/%d/%y")

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
							:actor => actor,
							:img_src => img_src
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
				rescue
					logger.info "====Error in processing feed item.====="
					next
				end
			end
			respond_to do |format|
				format.html
				format.json { render json: Feed.last }
			end	
		rescue
			respond_to do |format|
				format.html
				format.json { render json: {error: "No items found in the feed."}}
			end		
		end
	end

	def index
		render :text => params["hub.challenge"]
	end

end