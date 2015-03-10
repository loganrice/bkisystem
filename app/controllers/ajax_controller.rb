class AjaxController < ApplicationController
  def item_names
    if params[:term]
      like = "%".concat(params[:term].concat("%"))
      items = Item.where("name @@ ?", like)
    else
      items = Item.all
    end
    list = items.map {|u| Hash[ id: u.id, label: u.name, name: u.name]}
    render json: list
  end

  def filter_items_by_variety
    Item.where("variety_id = #{params[:variety]}")
  end
end
