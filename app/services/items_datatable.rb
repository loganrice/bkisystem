class ItemsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Item.count,
      iTotalDisplayRecords: items.total_entries,
      aaData: data
    }
  end

  private

  def data
    items.map do |item|
      [
        item.id,
        item.name,
        item.commodity.name.to_s,
        item.size.name.to_s,
        item.variety.name.to_s,
        item.grade.name.to_s
      ]
    end
  end

  def items
    @items ||= fetch_items
  end

  def fetch_items
    # pluralize sort_column for database query
    if sort_column == "name" or sort_column == "id"
      items = Item.order("#{sort_column} #{sort_direction}")
    else
      items = Item.joins(:variety, :commodity, :size, :grade).order("#{sort_column.pluralize}.name #{sort_direction}")
    end
    items = items.page(page).per_page(per_page)
    if params[:sSearch].present?
      items = items.where("name @@ :search", search: "#{params[:sSearch]}")
    end
    items
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name commodity size variety grade]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
