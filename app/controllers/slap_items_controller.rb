require 'slap_item'
class SlapItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit,:update_item]
  def index
  @page = params[:pg].to_i
  @limit = 5
   @item_data = SlapItem.gen_pagination(@page,@limit)
  end
  # GET /slap_items/new
  def new
    @item = SlapItem.new
  end

  def show
  end
  def update_item
      respond_to do  |format|
        if @item.update(item_params)
        format.html{redirect_to slap_index_url,notice: t(:item_successfully_updated) }
        format.json{render :show,status: :updated,location: slap_items_url}
        else
          format.html{redirect_to :edit }
          format.json{render  json: @item.errors,status: :unprocessable_entity}
        end

    end
  end

  # POST /slap_edit/create
  def create
    @item  = SlapItem.new(item_params)
    respond_to do |format|
      if @item.save
      format.html{redirect_to slap_index_url, notice: t(:item_successfully_added)}
      format.json{render :show,status: :created,localion: slap_index_url }
      else
        format.html{render :action => :new }
        format.json{render json: @item.errors,status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def set_item
    @item = SlapItem.find(params[:id])
  end
  def item_params
    params.require(:slap_item).permit(:item_title,:item_description)
  end


end