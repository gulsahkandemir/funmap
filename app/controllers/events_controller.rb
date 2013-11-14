class EventsController < ApplicationController

	def index
		@feeds = Feed.find(:all, :conditions => ['date >= ?', Date.today])
		@hash = Gmaps4rails.build_markers(@feeds) do |feed,marker|
			marker.lat feed.latitude
			marker.lng feed.longitude
			marker.json({:id => feed.id })
			marker.infowindow generate_info_window_html(feed)
		end

		@marker_lat = Feed.first.latitude
		@marker_lng = Feed.first.longitude
		@marker_title = Feed.first.title
	end

	def generate_info_window_html(feed)
		html = ""
		html << "<a href=\"" << feed.id_feed << "\" target=\"_blank\">" << feed.title << "</a><br>" 
		if !feed.img_src.nil?
			html << "<img src=\"" << feed.img_src << "\" height=\"150\" align=left>"
		end
		if !feed.summary.nil?
			html << "<p>" + feed.summary[0..100] + "</p>"	
		end
		return html
	end
end
