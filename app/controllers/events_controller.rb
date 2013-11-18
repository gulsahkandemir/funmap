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
		selected_categories = params[:categories]
		feeds = Feed.joins(:feed_has_categories)
					.where("feed_has_categories.category_id" => selected_categories)

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
		hash = Gmaps4rails.build_markers(feeds) do |feed,marker|
			marker.lat feed.latitude
			marker.lng feed.longitude
			marker.json({:id => feed.id })
			marker.infowindow template.result(binding)
		end		
		return hash
	end
end