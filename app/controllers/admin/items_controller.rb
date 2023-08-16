class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.all
  end
  
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新規登録をしました"
      redirect_to admin_item_path(@item.id)
    else
      render :index
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :category_id, :introduction, :price, :image, :inventory)
  end
  
end
