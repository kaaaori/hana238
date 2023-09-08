class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_cart_item, only: [:increase, :decrease, :destroy]
  
  def index
    @cart_items = current_customer.cart_items
    @items = Item.all
    @total = 0
    # @cart_items = Cart_Item.page(params[:page]).per(10)
  end

  def create
    cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if cart_item.present?
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount: cart_item.amount)
      redirect_to cart_items_path
    else
      cart_item = CartItem.new(cart_item_params)
      cart_item.customer_id = current_customer.id
      cart_item.save
      redirect_to cart_items_path
    end
  end
  
  def update
     cart_item = CartItem.find(params[:id])
     cart_item.update(cart_item_params)
     redirect_to cart_items_path
  end

  def increase
    @cart_item.increment!(:quantity, 1)
    redirect_to request.referer, notice: 'Successfully updated your cart'
  end

  def decrease
    decrease_or_destroy(@cart_item)
    redirect_to request.referer, notice: 'Successfully updated your cart'
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
  
  def set_cart_item
    @cart_item = current_customer.cart_items.find(params[:id])
  end
  
  
  def increase_or_create(item_id)
    cart_item = current_customer.cart_items.find_by(item_id)
    if cart_item
      cart_item.increment!(:quantity, 1)
    else
      current_customer.cart_items.build(item_id).save
    end
  end

  def decrease_or_destroy(cart_item)
    if cart_item.quantity > 1
      cart_item.decrement!(:quantity, 1)
    else
      cart_item.destroy
    end
  end
end