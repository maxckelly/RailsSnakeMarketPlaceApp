class ListingsController < ApplicationController

  # The before action allows us to run one command instead of three. It says basically it is going to run show, edit, update and destroy. So before you do any actions its going to call set_listing
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show ] 
  before_action :set_user_listing, only: [ :edit, :update, :destroy]


  def index
    @listings = current_user.listings
  end

  def show
    
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
    end
  end

  def listing_params 
   params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)
  end
    
end