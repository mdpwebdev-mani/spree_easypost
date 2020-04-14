module Spree
  module Api
    module V1
      ShipmentsController.class_eval do

          def buy_postage
              begin
                  find_and_update_shipment
                  unless @shipment.tracking_label?
                      raise NotImplementedError 
                      @shipment.buy_easypost_rate
                      @shipment.save!
                      #unless @shipment.shipped?
                          #@shipment.ship!
                      #end
                  end
                  flash[:notice] = 'Postage Succesfully Purchased.'
                  respond_with(@shipment, default_template: :show)
              rescue ::EasyPost::Error => e
                flash[:error] = e.message 
                respond_with(@shipment, default_template: :show)
              rescue Exception => e  
                flash[:error] = e.message 
                respond_with(@shipment, default_template: :show)
              end
          end

          def scan_form
              begin
                  @scan_form = Spree::ScanForm.create!(stock_location_id: params[:stock_location_id])
                  render json: { scan_form: @scan_form.scan_form }
              rescue Exception => e
                  render json: { :error => e.message } , :status => :bad_request
              end
          end

      end
    end
  end
end
