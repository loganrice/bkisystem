class Commission < ActiveRecord::Base
  belongs_to :order
  belongs_to :broker, :class_name => "Account"

  def dollars_per_pound
    self.cents_per_pound.to_f / 100
  end

  def dollars_per_pound=(dollars)
    self.cents_per_pound = (dollars.to_f * 100).to_i
  end

  def dollars
    self.cents.to_f / 100
  end

  def dollars=(dollars)
    self.cents = (dollars.to_f * 100).to_i
  end
end