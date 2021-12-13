class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update]

  def index
    @items = Item.all.order('created_at DESC')
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_form_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    redirect_to root_path if @item.order.present?

    # @itemから情報をハッシュとして取り出し、@item_formとしてインスタンス生成する
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
    @item_form.tag_name = @item.tags&.first&.tag_name
  end

  def update
    # paramsの内容を反映したインスタンスを生成する
    @item_form = ItemForm.new(item_form_params)

    # 画像を選択し直していない場合は、既存の画像をセットする
    @item_form.images ||= @item.images.blobs

    if @item_form.valid?
      @item_form.update(item_form_params, @item)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    redirect_to root_path if @item.destroy
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def look
    @q = Item.ransack(params[:q])
    @items = @q.result
  end

  private

  def item_form_params
    params.require(:item_form).permit(:name, :info, :category_id, :condition_id, :delivery_fee_id, :prefecture_id,
                                 :scheduled_delivery_id, :price, :tag_name, {images: []}).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @item.user.id == current_user.id
  end
end
