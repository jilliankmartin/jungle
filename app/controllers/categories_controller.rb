class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @products = @category.products.order(created_at: :desc)
    raise @products.inspect
  end

end
