class FavouritesController < ApplicationController
    before_action :authenticate_user!

    def index 
        @favourites = current_user.favourited_products.order('favourites.created_at DESC')
    end

    def create 
        product = Product.find params[:product_id]
        favourite = Favourite.new user: current_user, product: product 
        if !can?(:favourite, product) 
            flash[:warning] = "Hey! you can not favourite your own product"
        elsif favourite.save 
            flash[:success] = "Favourited!"
        else 
            flash[:alert] = favourite.errors.full_messages.join(', ')
        end
        redirect_to product 
    end

    def destroy 
        favourite = Favourite.find params[:id]
        if can? :destroy, favourite 
            favourite.destroy 
            flash[:warning] = "Unfavourited product"
        else 
            flash[:alert] = "Cannot unfavourite the product"
        end
        redirect_to favourite.product 
    end
end
