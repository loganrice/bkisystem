class ContractReport
  def initialize(contract)
    @contract = contract
    @line_items = each_line_item
    @order_items = order_items
    @items = all_items
    @orders = @contract.orders
  end

  def each_line_item
    items = []
    @contract.orders.each do |order|
      order.order_line_items.each do |line_item|
        items << line_item
      end
    end
    items
  end

  def commodity_season
    commodities = []
    @line_items.each do |line_item|
      origin = line_item.item.origin.name
      commodity = line_item.item.commodity.name
      season = line_item.season
      commodities << "#{origin} #{commodity} - #{season}"
    end
    commodities.uniq
  end

  def number_of_shipments(item)
    shipment_count = 0 
    @items.each do |key, value|
      if key == item 
        shipments_count += 1
      end
    end
    shipments_count
  end

  def documents
    documents = []
    @orders.each do |order|
      order.documents.each do |doc|
        documents << doc.name
      end
    end
    documents.uniq.join(", ") 
  end

  def signature
    "A signed copy of this contract to be returned to #{@contract.seller.name}. " +
    "Failure to do so, and retention of this contract constitutes acceptance of the contract."
  end

  def price
    message = []
    @items.each do |item|
      message << "#{item[:grade]} #{item[:size]} #{item[:size_indicator]} " +
                  "#{helpers.number_to_currency(item[:price_dollars])}/#{item[:uom]} " +
                  "FAS Oakland"
    end
    message.uniq
  end

  def quantity
    message = "" 
    sizes = order_container_sizes
    sizes.each_with_index do |(key, value), index|
      if index == 0 
        message << "#{value} X #{key}"
      else
        message << ", and #{value} X #{key}"
      end 
    end
    message 
  end

  def weight
    message = "About #{helpers.number_with_precision(@contract.total_pounds, precision: 0, separator: ',', delimiter: ',')} Lbs. in #{helpers.pluralize(@contract.orders.count, 'shipment')}"
  end

  def quality
    message = []
    @order_items.each do |item_id, description|
      unless message.include? description
        message << description 
      end 
    end
    message
  end

  def all_items
    items = []
    @line_items.each do |line_item|
      items << get_item_properties(line_item)
    end
    items
  end

  def all_uniq_items
    uniq_items = {}
    @items.each do |item|
      if uniq_items.has_key? item[:description]
        uniq_items[item[:description]][:pack_count] += item[:pack_count]
        if item[:order_id] != uniq_items[item[:description]][:order_id]
          uniq_items[item[:description]][:shipments_count] += 1
        end
      else
        uniq_items[item[:description]] = { pack_count: item[:pack_count],
                                        weight: item[:weight],
                                        variety: item[:variety],
                                        commodity: item[:commodity],
                                        grade: item[:grade],
                                        size: item[:size],
                                        size_indicator: item[:size_indicator],
                                        pack_type: item[:pack_type],
                                        uom: item[:uom],
                                        order_id: item[:order_id],
                                        shipments_count: 1
                                      }
      end 
    end
    uniq_items
  end

  def packaging_message
    message = []
    all_uniq_items.each do |key, value|
      message << "#{value[:pack_count]} X #{value[:weight]} #{value[:uom]} #{value[:pack_type]} in #{helpers.pluralize(value[:shipments_count], 'shipment')}"
    end
    message  
  end

  private

  def helpers
    ActionController::Base.helpers
  end
  


  def order_container_sizes
    container_sizes = {}
    @contract.orders.each do |order|
      if container_sizes.has_key? order.container_size
        container_sizes[order.container_size] = (container_sizes[order.container_size] + 1)
      else
        container_sizes[order.container_size] = 1
      end
    end
    container_sizes 
  end

  def order_items
    items = {}
    @line_items.each do |line_item|
      unless items.has_key? line_item.item_id
        description = item_description(line_item.item_id, line_item.item_size_indicator_id)
        items[line_item.item_id] = description
      end 
    end
    items 
  end



  def item_description(item_id, size_indicator_id)
    item = Item.find(item_id)
    size_indicator = ItemSizeIndicator.find(size_indicator_id)
    if item
      description = "#{item.variety.name} #{item.commodity.name} #{item.grade.name} #{item.size.name} #{size_indicator.name}"
    end 
  end

  def get_item_properties(line_item)
    item_properties = {}
    item = Item.find(line_item.item_id)
    size_indicator = ItemSizeIndicator.find(line_item.item_size_indicator_id)
    pack_type = PackType.find(line_item.pack_type_id).name
    uom = Weight.find(line_item.weight_id).weight_unit_of_measure
    if item 
      item_properties[:description] = "#{item.variety.name} #{item.commodity.name} #{item.grade.name} #{item.size.name} #{size_indicator.name} #{line_item.pack_weight_pounds}"
      item_properties[:weight] = line_item.pack_weight_pounds
      item_properties[:pack_count] = line_item.pack_count
      item_properties[:variety] = item.variety.name
      item_properties[:commodity] = item.commodity.name
      item_properties[:grade] = item.grade.name
      item_properties[:size] = item.size.name
      item_properties[:size_indicator] = size_indicator.name
      item_properties[:pack_type] = pack_type
      item_properties[:uom] = uom
      item_properties[:order_id] = line_item.order.id
      item_properties[:line_item_id] = line_item.id 
      item_properties[:price_dollars] = line_item.price_dollars

    end 
    item_properties
  end

end