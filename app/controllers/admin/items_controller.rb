class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.order('id DESC').limit(15)
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
      render :new
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "変更を保存しました"
      redirect_to admin_item_path(@item.id)
    else
      render :edit
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
      redirect_to items_path, notice: "削除しました"
    else
      flash.now[:danger] = "削除に失敗しました"
      render :index
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :category_id, :introduction, :price, :image, :inventory)
  end
  
end
