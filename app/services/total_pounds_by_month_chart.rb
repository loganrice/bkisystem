class TotalPoundsByMonthChart
  def chart_data(start = 1.months.ago.to_date)
    total_pounds = total_pounds_by_month(start)
    (start..Date.today).map do |date|
      {
        date: date,
        pounds: total_pounds[date] || 0
      }
    end
  end

  def total_pounds_by_month(start)
    month_keys = (start..Date.today).map {|date| date.beginning_of_month}
    month_keys = month_keys.uniq
    pounds = Hash[month_keys.map {|key| [key, 0]}]
    orders = Order.where(created_at: start.beginning_of_day..Time.zone.now)
    orders.each do |order|
      order_date = order.created_at.to_date.beginning_of_month
      pounds[order_date] += order.total_pounds.to_i
    end 
    pounds
  end
end