class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_available, only: [:index, :create]
  before_action :prohibit_buy_back, only: [:index, :create]

  def item_available
    @item = Item.find(params[:item_id])
    return if @item.on_sale

    # 売り切れであればトップページに遷移する
    flash[:notice] = "この商品は売り切れです。購入できません。"
    redirect_to root_path
  end

  def prohibit_buy_back
    @item = Item.find(params[:item_id])
    return unless @item.owner(current_user)

    # 出品者が自分の商品の購入URLにアクセスしたらトップページに遷移する
    flash[:notice] = "出品者がご自身の商品を購入することはできません。"
    redirect_to root_path
  end

  def index
    @order = PurchaseShipping.new(user_id: current_user.id, item_id: params[:item_id])
  end

  def create
    @order = PurchaseShipping.new(purchase_params)
    if @order.valid?
      pay_item
      @order.save
      flash[:notice] = "商品を購入しました"
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def purchase_params
    params.permit(:purchase_shipping).permit(
      :token, :purchase_id, :zip, :prefecture, :city,
      :address, :building, :phone,
    ).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = "sk_test_39407efff624d99a308f69de"  # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: order_params[:price],  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency:'jpy'                 # 通貨の種類(日本円)
    )
  end
end
