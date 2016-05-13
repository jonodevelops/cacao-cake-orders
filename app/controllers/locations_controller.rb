class LocationsController < ApplicationController
  before_action :allow_admin, except: [:show, :index]
  before_action :set_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @orders = Location.find(params[:id]).pickups_at.sorted.upcoming
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
      if @location.save
        redirect_to :locations, notice: 'Location was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
      if @location.update(location_params)
        redirect_to :locations, notice: 'Location was successfully updated.'
      else
       render :edit
      end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    if @location.has_orders?
      redirect_to :locations, notice: 'Cannot destroy Location with associated Orders'
    elsif @location.has_users?
      redirect_to :locations, notice: 'Cannot destroy Location with associated Users'
    else
      if @location.destroy 
        redirect_to :locations, notice: 'Location was successfully destroyed.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name)
    end
end
