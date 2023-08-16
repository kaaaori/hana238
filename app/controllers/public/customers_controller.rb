class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end
  
  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to mypage_path
    else
      render :edit
    end
  end
  
  def unsubscribe #登録解除画面
    
  end

  def withdrawal #退会
    @customer = current_customer
    @customer.update(is_deleted: true)#is_deletedカラムをtrueに変更することで退会扱い
    reset_session#ログアウトさせる
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :postal_code, :address, :phone_number, :email)
  end
end