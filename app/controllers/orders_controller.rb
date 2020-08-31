class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_available, only: [:index, :create]
  before_action :confirm_seller, only: [:index]

  def item_available
    @item = Item.find(params[:item_id])
    return if @item.on_onsale

    # 売り切れであればトップページに遷移する
    flash[:notice] = "この商品は売り切れです。購入できません。"
    redirect_to root_path
  end

  def confirm_seller
    @item = Item.find(params[:item_id])
    return unless @item.owner(current_user)

    # 出品者が自分の商品の購入ページにアクセスしたらトップページに遷移する
    flash[:notice] = "この商品の出品者です。購入できません"
    redirect_to root_path
  end

  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @item = Item.find(params[:item_id])
    @user = current_user
    @order = Purchase.()
  end

  private

  def order_params
    params.require(:purchase).permit(:item).merge(user_id: current_user.id)
  end
end
