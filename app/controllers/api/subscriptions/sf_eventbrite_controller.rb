require 'open-uri'
class Api::Subscriptions::SfEventbriteController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        # initialize eventbrite client
        eb_auth_tokens = { app_key: Rails.application.config.eventbrite_key}
        eb_client = EventbriteClient.new(eb_auth_tokens)

        items = params[:items]
        items.each do |item|
            begin
                event_id_regex = /\/e\/(.*)\?/
                event_id = item[:id].match(event_id_regex)[1]

                response = eb_client.event_get({ id: event_id})
                event = JSON.parse(response.body, {:symbolize_names => true})[:event]

                # Check for a duplicate actor first
                actor = Actor.find_by(id_actor: event[:organizer][:id])
                if actor.blank?
                    actor = Actor.new(
                        :display_name => event[:organizer][:name], 
                        :permalink_url => event[:organizer][:url],
                        :id_actor => event[:organizer][:id]
                        ) 
                    actor.save
                end
                
                # Check for a duplicate feed first
                feed = Feed.find_by(id_feed: item[:id])
                if feed.blank?
                    feed = Feed.new(
                        :id_feed => item[:id],  
                        :title => event[:title], 
                        :summary => event[:description],
                        :content => event[:description],
                        :permalink_url => item[:permalinkUrl], 
                        :latitude => event[:venue][:latitude],
                        :longitude => event[:venue][:longitude],
                        :address =>  event[:venue][:name] << ", " << event[:venue][:address] \
                            << ", " << event[:venue][:address_2] << ", " << event[:venue][:city] \
                            << ", " << event[:venue][:region] << ", " << event[:venue][:postal_code] \
                            << ", " << event[:venue][:country],
                        :date => event[:start_date],
                        :img_src => event[:logo],
                        :actor => actor,
                        :source => "sf_eventbrite"
                        )
                    feed.save
                end

                category_string = event[:category]
                categories = category_string.split(",")
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
            format.json { render json: Feed.last}
        end 
    end

    def index
        render :text => params["hub.challenge"]
    end
end