class Api::Subscriptions::SfEventbriteController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        logger.info "=========START=EVENTBRITE========="
        logger.info request.env
        logger.info "==============PARAMS=============="
        logger.info params
        logger.info "==========END=EVENTBRITE=========="

        respond_to do |format|
            format.html
            format.json { render json: params}
        end 
    end
end