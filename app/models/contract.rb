class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => "Account"
  belongs_to :buyer, :class_name => "Account"
  has_many :orders
  has_one :quote
  has_many :quote_line_items, through: :quote
  accepts_nested_attributes_for :orders, allow_destroy: true
  accepts_nested_attributes_for :quote, allow_destroy: true
  before_create :create_quote

  private 

  def create_quote
    self.quote ||= Quote.create()
  end

end