class EventsController < ApplicationController

	def index
		@feeds = Feed.all
		@hash = Gmaps4rails.build_markers(@feeds) do |feed,marker|
			marker.lat feed.latitude
			marker.lng feed.longitude
			marker.json({:id => feed.id })
			marker.infowindow feed.title
		end

		@marker_lat = Feed.first.latitude
		@marker_lng = Feed.first.longitude
		@marker_title = Feed.first.title
	end

	def generate_info_window_html(feed)
		html
	end
end
