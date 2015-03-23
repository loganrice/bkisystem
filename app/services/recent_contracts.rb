class RecentContracts
  def last_3_days
    result = Contract.where(updated_at: 4.days.ago..Date.tomorrow)
  end
end