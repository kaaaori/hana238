class Public::Categories::ItemsController < ApplicationController
  # before_action :authenticate_customer!
  
  def index
    @category = Category.find(params[:category_id])
    @items = @category.items
  end
  
end
