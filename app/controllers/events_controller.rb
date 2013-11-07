class EventsController < ApplicationController

	def index
		@feeds = Feed.all
	end
end
