class EventsController < ApplicationController

	def index
		template_string = File.open("app/views/events/_info_popover.html.erb").read
		template = ERB.new(template_string)
		@feeds = Feed.find(:all, :conditions => ['date >= ?', Date.today])
		@hash = Gmaps4rails.build_markers(@feeds) do |feed,marker|
			marker.lat feed.latitude
			marker.lng feed.longitude
			marker.json({:id => feed.id })
			marker.infowindow template.result(binding)
		end

		@top_categories = Category.joins(:feed_has_categories)
									.select('categories.id, categories.title, count(*) as "feed_count"')
									.group(:category_id)
									.order('feed_count desc')
									.to_a[0..8]
	end
end