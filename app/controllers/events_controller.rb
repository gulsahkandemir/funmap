class EventsController < ApplicationController

	def index
		feeds = Feed.find(:all, :conditions => ['date >= ?', Date.today])
		@hash = buildMarkersFromFeeds(feeds)

		@top_categories = Category.joins(:feed_has_categories)
									.select('categories.id, categories.title, count(*) as "feed_count"')
									.group(:category_id)
									.order('feed_count desc')
									.to_a[0..8]
	end

	def search
		if !params[:categories].nil?
			selected_categories = params[:categories]
		end

		if !params[:date_range].nil?
			date_first, date_last = params[:date_range].split(" - ")
		end

		feeds = Feed.joins(:feed_has_categories)
		if (selected_categories || date_first || date_last)
			if(selected_categories)
				feeds = feeds.where("feed_has_categories.category_id" => selected_categories)
			end
			if(date_first && date_last)
				feeds = feeds.where(date: (Date.strptime(date_first,"%m/%d/%Y").strftime("%Y-%m-%d")..Date.strptime(date_last,"%m/%d/%Y").strftime("%Y-%m-%d")))
			elsif (date_first)
				feeds = feeds.where(date: Date.strptime(date_first,"%m/%d/%Y").strftime("%Y-%m-%d"))
			else
				feeds = feeds.where(['date >= ?', Date.today])
			end
		else 
			feeds = feeds.where(['date >= ?', Date.today])
		end
		feeds = feeds.uniq
		

		hash = buildMarkersFromFeeds(feeds)
		
		respond_to do |format|
			format.html
			format.xml { render xml:  hash}
			format.json { render json: hash}
		end	
	end

	def buildMarkersFromFeeds(feeds)
		template_string = File.open("app/views/events/_info_popover.html.erb").read
		template = ERB.new(template_string)

		markers = Array.new
		feeds.each do |feed|
			marker = Hash.new
			marker["lat"] = feed.latitude.to_f
			marker["lng"] = feed.longitude.to_f
			marker["infoWindowContent"] = template.result(binding)
			markers << marker
		end
		return markers
	end
end