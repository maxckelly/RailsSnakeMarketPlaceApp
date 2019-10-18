class ListingsController < ApplicationController
  # The before action allows us to run one command instead of three. It says basically it is going to run show, edit, update and destroy. So before you do any actions its going to call set_listing
  before_action :set_listing, only: [ :show, :edit, :update, :destroy]
  def index
    @listings = Listing.all
  end

  def show
    
  end

  def new
    @listing = Listing.new
    # The below defaults to the date when created. 
    @listing.date_of_birth = "1971-01-01"
  end

  def create
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet)
    @listing = Listing.new(listing_params)

    if @listing.save
      redirect_to @listing
    else 
      render :new
    end
  end

  def edit

  end

  def update
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet)

    @listing.update(listing_params)
    redirect_to @listing
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
end