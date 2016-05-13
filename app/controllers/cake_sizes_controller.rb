class CakeSizesController < ApplicationController
  before_action :allow_admin
  before_action :set_cake_size, only: [:edit, :update, :destroy]

  # GET /cake_sizes
  def index
    @cake_sizes = CakeSize.all
  end

  # GET /cake_sizes/new
  def new
    @cake_size = CakeSize.new
  end

  # GET /cake_sizes/1/edit
  def edit
  end

  # POST /cake_sizes
  def create
    @cake_size = CakeSize.new(cake_size_params)
      if @cake_size.save
        redirect_to cake_sizes_path, notice: 'Cake size was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /cake_sizes/1
  def update
      if @cake_size.update(cake_size_params)
        redirect_to cake_sizes_path, notice: 'Cake size was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /cake_sizes/1
  def destroy
    if @cake_size.has_orders?
      redirect_to :cake_sizes, notice: 'Cannot destroy Cake Size with associated Orders'
    else
      if @cake_size.destroy 
        redirect_to :cake_sizes, notice: 'Cake Size was successfully destroyed.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cake_size
      @cake_size = CakeSize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cake_size_params
      params.require(:cake_size).permit(:name)
    end
end
