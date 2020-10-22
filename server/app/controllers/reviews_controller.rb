class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_review!, except: [:create]
  before_action :authorize_user!, only: [:destroy]

  def create
    @product = Product.find params[:product_id]
    @review = Review.new params.require(:review).permit(:rating, :body)
    @review.product = @product
    @review.user = @current_user
    
    if @review.save
      ReviewMailer.notify_product_owner(@review).deliver_later
      redirect_to product_path(@product)
    else
      render 'products/show'
    end
  end
  
  def destroy
    @review.delete
    redirect_to product_path(@review.product)
  end

  private

  def authorize_user!
    unless can? :crud, @review
      flash[:danger] = "Access Denied"
      redirect_to root_path
    end
  end

  def load_review!
    if params[:id].present?
      @review = Review.find params[:id]
    else
      @review = Review.new
    end
  end
end
