class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    if current_customer.cart_items.empty?
      redirect_to cart_items_path
    end
    @customer = current_customer
  end
  
  def confirm
    # 余力次第でリファクタリングしたい箇所（カラムから？）
    @order = current_customer.orders.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.prefecture_code = current_customer.prefecture_code
      @order.address_city = current_customer.address_city
      @order.address_street = current_customer.address_street
      @order.address_building = current_customer.address_building
      @order.address_name = current_customer.last_name + current_customer.first_name
      @order.phone_number = current_customer.phone_number
    elsif params[:order][:select_address] == "1"
      @address = DeliveryAddress.find(params[:order][:delivery_address_id])
      @order.postal_code = @address.postal_code
      @order.prefecture_code = @address.prefecture_code
      @order.address_city = @address.address_city
      @order.address_street = @address.address_street
      @order.address_building = @address.address_building
      @order.address_name = @address.address_name
      @order.phone_number = @address.phone_number
    elsif params[:order][:select_address] == "2"
    end
    
    # TODO: 支払い方法の選択ができるようになったら消す
    @order.payment_method = :credit_card
    @cart_items = current_customer.cart_items
  end
  
  def create
    # 余力あればリファクタリングする
    @cart_items = current_customer.cart_items.all
    @cart_items.each do |cart_item|
      if !cart_item.item.enough_inventory?(cart_item.amount)
        redirect_to cart_items_path, notice: "在庫が足りませんでした"
        return
      end
    end
    @order = Order.new(order_params)
    
    if @order.save
      @cart_items.each do |cart_item|
        @order_details = OrderDetail.new
        @order_details.order_id = @order.id
        @order_details.item_id = cart_item.item.id
        @order_details.price_intax = cart_item.item.with_tax_price
        @order_details.amount = cart_item.amount
        if @order_details.save
          item = Item.find(cart_item.item_id)
          item.inventory -= cart_item.amount
          item.save
        end
      end
      current_customer.cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render :new
    end
  end
  
  def thanks
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end
  
  def index
    @orders = current_customer.orders
    @order_details = OrderDetail.where(order_id: params[:id])
  end
  
  private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :prefecture_code, :address_city, 
      :address_street, :address_building, :address_name, :postage, :total, :customer_id, :delivery_day, :delivery_time, :phone_number)
    end
end
