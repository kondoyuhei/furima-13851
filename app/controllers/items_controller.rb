class ItemsController < ApplicationController
  # ログイン確認をする
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.includes(:user).order(created_at: "DESC")
    @purchases = Purchase.all
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name, :note, :price, :image, :category, :condition, :charge, :from, :period).merge(user_id: current_user.id)
  end

end
