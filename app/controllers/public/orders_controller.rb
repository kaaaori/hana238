class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    if current_customer.cart_items.empty?
      redirect_to cart_items_path
    end
  end
  
  def confirm
     @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.address_name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "1"
      @address = DeliveryAddress.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.address_name = @address.name
    elsif params[:order][:select_address] == "2"
      @order.customer_id = current_customer.id
    end
      @cart_items = current_customer.cart_items
      @order_new = Order.new
      render :confirm
  end
  
  def index
    @orders = current_customer.orders
    @order_details = OrderDetail.where(order_id: params[:id])
  end
  
  private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :prefecture_code, :address_city, :address_street, :address_building, :address_name, :postage, :total, :customer_id )
    end
end
