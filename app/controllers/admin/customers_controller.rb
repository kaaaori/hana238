class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.all
  end
  
  def show
     @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "変更を保存しました"
      redirect_to admin_customer_path(@customer.id)
    else
      render :edit
    end
  end
  
 private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :postal_code, :prefecture_code, :address_city, :address_street, :address_building, :phone_number, :email)
  end
end
