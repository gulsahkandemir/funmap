class Api::TestfeedsController < ApplicationController

	def create

	end

	def index
		@testfeeds = Testfeed.all
		respond_to do |format|
	    	format.html
	    	format.xml { render xml: @testfeeds }
	    	format.json { render json: @testfeeds }
	  	end
	end

end