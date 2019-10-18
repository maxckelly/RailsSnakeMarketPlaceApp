class BreedsController < ApplicationController
  before_action :set_breed, only: [ :show, :edit, :update, :destroy]

  def view
    @breeds = Breed.all
  end

  def show

  end

  def new
    @breed = Breed.new
  end

  def create
    breed_params = params.require(:breed).permit(:name)
    @breed = Breed.new(breed_params)
    @breed.save

    redirect_to @breed
  end

  def edit 
    
  end

  def update

  end

  def destroy

  end

  private
  def set_breed
    id = params[:id]
    @breed = Breed.find(id)
  end
end