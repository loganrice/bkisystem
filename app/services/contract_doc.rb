class ContractDoc
  include DocxReplace

  def initialize(contract)
    @doc = DocxReplace::Doc.new("#{Rails.root}/app/reports/contract.docx", "#{Rails.root}/tmp")
    @contract = contract
    @line_items = each_line_item
    @order_items = order_items
    @items = all_items
    @orders = @contract.orders
    create_contract
  end

  def create_contract
    @doc.replace( "[[CONTRACT_NO]]", @contract.seller_contract.to_s)
    @doc.replace( "[[CUSTOMER_CONTRACT_NO]]", @contract.buyer_contract.to_s)
    @doc.replace( "[[SELLER_NAME]]", @contract.seller.try(:name).to_s)
    @doc.replace( "[[SELLER_LINE1]]", ensure_string(seller_address, :line1))
    @doc.replace( "[[SELLER_CITY]]", ensure_string(seller_address, :city))
    @doc.replace( "[[SELLER_STATE]]", ensure_string(seller_address, :state))
    @doc.replace( "[[SELLER_ZIP]]", ensure_string(seller_address, :zip))
    @doc.replace( "[[BUYER_NAME]]", @contract.buyer.try(:name).to_s)
    @doc.replace( "[[BUYER_LINE1]]", ensure_string(buyer_address, :line1))
    @doc.replace( "[[BUYER_CITY]]", ensure_string(buyer_address, :city))
    @doc.replace( "[[BUYER_STATE]]", ensure_string(buyer_address, :state))
    @doc.replace( "[[BUYER_ZIP]]", ensure_string(buyer_address, :zip))
    @doc.replace( "[[COMMODITY]]", commodity_season)
    @doc.replace( "[[DOCUMENTS]]", documents)
    @doc.replace( "[[QUANTITY]]", quantity)
    @doc.replace( "[[WEIGHT]]", weight)
    @doc.replace( "[[QUALITY]]", quality)
    @doc.replace( "[[PACKING]]", packaging_message)
    @doc.replace( "[[SHIPMENT]]", @contract.ship_date_note.to_s)
    @doc.replace( "[[PRICE]]", price)
    @doc.replace( "[[PAYMENT]]", @contract.payment_terms.to_s)
    @doc.replace( "[[REMARKS]]", @contract.remarks.to_s)
    @doc.replace( "[[SIGNATURE]]", @contract.seller.try(:name).to_s)

    temp_file
  end

  def buyer_address
    return @buyer_address if defined? @buyer_address
    @buyer_address = @contract.buyer.try(:addresses).try(:first)
  end

  def seller_address
    return @seller_address if defined? @seller_address
    @seller_address = @contract.seller.try(:addresses).try(:first)
  end

  def ensure_string(object, method)
    object.try(method) || ""
  end

  def temp_file
    # Write the document back to a temporary file
    tmp_file = Tempfile.new('word_tempate', "#{Rails.root}/tmp")
    @doc.commit(tmp_file.path)
    return tmp_file.path 
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
    commodities.uniq.join(", ")
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
      message << "#{item[:grade]} #{item[:shell]} #{item[:size]} #{item[:size_indicator]} " +
                  "#{helpers.number_to_currency(item[:price_dollars])}/#{item[:uom]} " +
                  "FAS Oakland"
    end
    message.uniq.join("</w:t><w:br/><w:t>").gsub(/NA/, "").gsub(/Shelled/, "").squeeze(" ")
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
    message.join(", ").gsub(/NA/, "").gsub(/Shelled/, "").squeeze(" ")
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
    message.join(", ").squeeze(" ")
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
      description = "#{item.variety.try(:name)} #{item.commodity.try(:name)} #{item.shell.try(:name)} #{item.grade.try(:name)} #{item.size.name} #{size_indicator.name}"
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
      item_properties[:variety] = item.variety.try(:name)
      item_properties[:commodity] = item.commodity.try(:name)
      item_properties[:grade] = item.grade.try(:name)
      item_properties[:size] = item.size.try(:name)
      item_properties[:shell] = item.shell.try(:name)
      item_properties[:size_indicator] = size_indicator.try(:name)
      item_properties[:pack_type] = pack_type
      item_properties[:uom] = uom
      item_properties[:order_id] = line_item.order.id
      item_properties[:line_item_id] = line_item.id 
      item_properties[:price_dollars] = line_item.price_dollars

    end 
    item_properties
  end

end