class OrdersController < ApplicationController
  require 'active_support'
  before_action :authenticate_user!
  before_action :set_item
  before_action :item_available, only: [:index, :create]
  before_action :prohibit_buy_back, only: [:index, :create]

  def set_item
    @item = Item.find(params[:item_id])
  end

  def item_available
    return if @item.on_sale

    # 売り切れであればトップページに遷移する
    flash[:notice] = "アクセスした商品は売り切れです。"
    redirect_to root_path
  end

  def prohibit_buy_back
    return unless @item.owner(current_user)

    # 出品者が自分の商品の購入URLにアクセスしたらトップページに遷移する
    flash[:notice] = "出品者が自分の出品した商品を購入することはできません。"
    redirect_to root_path
  end

  def index
    # バリデーションできるよう送り先情報にダミーの購入id（purchase_id）に「0」を代入する。
    # 購入の確定前は購入idが未定のため、送り先情報（@shipping）のバリデーションができない。
    @shipping = Shipping.new(purchase_id: 0)
  end

  def create
    # 送り先情報の保存には不要なパラメーターを削除する
    shipping_params = purchase_params.except(:price, :user_id, :item_id)
    @shipping = Shipping.new(shipping_params.merge(purchase_id: 0))
    binding.pry
    # 送り先のバリデーションが通れば購入を確定させる。
    if @shipping.valid?
      # 購入情報を保存する
      purchase = Purchase.create(
        user_id: purchase_params[:user_id],
        item_id: purchase_params[:item_id]
      )
      # 実際の購入idを送り先情報に設定して保存する
      @shipping.purchase_id = purchase.id
      @shipping.save
      # pay.jpに売上情報を送る
      pay_item
      # 成功メッセージとともにトップページに遷移する
      flash[:notice] = "カード決済と購入が完了しました。"
      redirect_to root_path
    else
      flash[:notice] = "カード決済・購入はまだ済んでいません。"
      render 'orders/index'
    end
  end

  private

  def purchase_params
    # 購入するアイテム・購入するユーザー・送り先の情報・カード決済トークンを含むストロングパラメーターの設定
    params.permit(
      :token, :zip, :prefecture, :city, :address, :building, :phone
    ).merge(user_id: current_user.id, item_id: @item.id, price: @item.price)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"] # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: purchase_params[:price], # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy'                   # 通貨の種類(日本円)
    )
  end
end
