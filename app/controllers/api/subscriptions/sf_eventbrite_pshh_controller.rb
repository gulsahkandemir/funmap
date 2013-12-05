class Api::Subscriptions::SfEventbritePshhController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        request.body.rewind
        request_body_json = JSON.parse(request.body.read);

        logger.info "=========START=EVENTBRITE=PSHH========"
        logger.info request.env
        logger.info "==============BODY=PSHH============="
        logger.info request_body_json
        logger.info "==========END=EVENTBRITE=PSHH========="

        respond_to do |format|
            format.html
            format.json { render json: request_body_json}
        end 
        
    end

    def index
        render :text => params["hub.challenge"]
    end
end