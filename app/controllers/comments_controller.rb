class CommentsController < ApplicationController
	before_action :allow_admin, only: [:destroy]
	#before_action :confirm_logged_in
	
	#http_basic_authenticate_with name: "Jono", password: "secret", only: :destroy

	def create
		@order = Order.find(params[:order_id])
		@comment = @order.comments.create(comment_params)
		redirect_to order_path(@order)
	end

	def destroy
		@order = Order.find(params[:order_id])
		@comment = @order.comments.find(params[:id])
		@comment.destroy
		redirect_to order_path(@order)
	end

	private

	def comment_params
		params.require(:comment).permit(:commenter, :body)
		
	end
end
