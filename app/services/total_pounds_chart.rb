class TotalPoundsChart
  def initialize(start = 1.months.ago.to_date)
    @start = start
    @orders = Order.includes(:order_line_items).where(created_at: @start.beginning_of_day..Time.zone.now)
    @data = self.pounds
  
  end

  def chart_data
    data = {}
    top_four_values = top_four.values 
    top_four_total = total(top_four)
    top_four.each do |variety, value|
      data[variety] = { "pounds" => value, "percentage" => 100 * (value / top_four_total) }
       
    end
    data
  end

  def pounds
    data = {}
    @orders.each do |order|

      order.order_line_items.each do |line_item|
        data[line_item.item.variety.name] = line_item.weight_total
      end
    end
    data.sort_by {|key, value| value}.to_h

  end

  def total(data)
    data.values.inject { |sum, value| sum + value }
  end

  def top_four
    data = {}
    pounds.each_with_index do |(variety, pound), index|
      break if index > 4
      data[variety] = pound
    end
    data
  end


  private 

  def line_items
    @orders.map do |order|
      order.order_line_items
    end
  end
end

# chart.width
# chart.pounds 
# chart.variety