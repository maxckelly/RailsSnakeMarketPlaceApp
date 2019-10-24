class ListingsController < ApplicationController

  # The before action allows us to run one command instead of three. It says basically it is going to run show, edit, update and destroy. So before you do any actions its going to call set_listing
  before_action :authenticate_user!
  before_action :set_user_listing, only: [ :edit, :update, :show, :destroy]


  def index
    @listings = current_user.listings
  end

  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: @listing.title,
        description: @listing.description,
        # We're timsing by 100 because stripe works in cents and we want to display dollars
        amount: @listing.deposit * 100, 
        currency: 'aud',
        # Quantity is the amount you're buying if you're selling based on quantity.
        quantity: 1
      }],
      payment_intent_data: {
        metadata: {
          user_id: current_user.id,
          # The below grabs the listing ID so it relates to the listing
          listing_id: @listing.id
        }
      },
      # This directs the user if the payment is successful 
      success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@listing.id}",
      cancel_url: "#{root_url}listings"
    )

    # This then sets the session above to an id.
    @session_id = session.id
  end

  def new
    @listing = Listing.new
    # The below defaults to the date when created. 
    @listing.date_of_birth = "1971-01-01"
  end

  def create
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)

    # This basically refers to the current user logged in. This is a devise thing.
    @listing = current_user.listings.new(listing_params)

    # Another way we can do the above is like the below. IF we use the below then the if statment is no longer needed
    # @listing = current_user.listings.create(listing_params)

    if @listing.save
      redirect_to @listing
    else 
      render :new
    end
  end
  
  def edit

  end

  def update

    # The below basically says - If the update works then redirect to @listing. If it doesn't it then re renders the edit page. 
    if @listing.update( listing_params )
      redirect_to @listing
    else
      render :edit
    end
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  # Anything below the word private will not be avaliable to anything other than the controller
  private
  # The point of the below is that it allows us to run the methods above once. The code below was once in all the above methods but we have deleted it.
  def set_listing
    id = params[:id]
    @listing = Listing.find(id)
  end

  def set_user_listing
    id = params[:id]
    @listing = current_user.listings.find_by_id(id)

    if @listing == nil
      redirect_to listings_path
    else 
      # The below if statement says if the value is nil then display 1 - However this shouldn't happen as a price should be a requirement. Stripe does not let this be 0 so this should be handled in the form creation.
      if @listing.deposit == nil
        @listing.deposit = 1
      end
    end
  end

  def listing_params 
   params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)
  end
    
end