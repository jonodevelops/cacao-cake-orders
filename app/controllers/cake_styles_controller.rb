class CakeStylesController < ApplicationController
  before_action :allow_admin, only: [ :destroy]
  before_action :set_cake_style, only: [:show, :edit, :update, :destroy]
  before_action :load_objects

  
  def index
    @cake_styles = CakeStyle.recent
  end

  def current
    @cake_styles = CakeStyle.current_styles
  end

  # GET /cake_styles/1
  # GET /cake_styles/1.json
  def show
    @upcoming_style_orders = CakeStyle.find(params[:id]).orders.sorted.upcoming
    @orders = @upcoming_style_orders
  end

  # GET /cake_styles/new
  def new
    @cake_style = CakeStyle.new
  end

  # GET /cake_styles/1/edit
  def edit
  end

  # POST /cake_styles
  # POST /cake_styles.json
  def create
    @cake_style = CakeStyle.new(cake_style_params)
      if @cake_style.save
        redirect_to @cake_style, notice: 'Cake style was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /cake_styles/1
  # PATCH/PUT /cake_styles/1.json
  def update
      if @cake_style.update(cake_style_params)
        redirect_to @cake_style, notice: 'Cake style was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /cake_styles/1
  # DELETE /cake_styles/1.json
  def destroy
    if @cake_style.has_orders?
      redirect_to @cake_style, notice: 'Cannot destroy Cake Styles with Orders'
    else
      if @cake_style.destroy 
        redirect_to cake_styles_url, notice: 'Cake style was successfully destroyed.'
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cake_style
      @cake_style = CakeStyle.find(params[:id])
    end

    def load_objects
      @cake_sizes = CakeSize.all
      
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cake_style_params
      params.require(:cake_style).permit(:name, :description, :current, :style_photo)
    end
end
