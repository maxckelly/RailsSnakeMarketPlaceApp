class PaymentsController < ApplicationController
  # While we're in the testing environment we're going to skip auth.
  skip_before_action :verify_authenticity_token, only: ( :webhook )
  before_action :set_listing, only: [:success]
  def success

  end

  def webhook 
    payment_id = params[:data][:object][:payment_intent]
    payment = Stripe::PaymentIntent.retrieve(payment_id)


    # This is getting the metadata that we have in listings_controller.rb and the show method.
    listing_id = payment.metadata.listing_id
    user_id = payment.metadata.user_id

    p "listing id = " + listing_id
    p "user id = " + user_id
    
    status 200
  end
  
  private 

  def set_listing
    listing_id = params[:listingId]
    @listing = Listing.find(listing_id)
  end
end