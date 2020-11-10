class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    # raise @products.inspect
  end

  def show
    @product = Product.find params[:id]
  end

end
