class OrderDetail 
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :type, :domain, :period, :authcode, :registrant_handle

  validates_presence_of :domain, :authcode, :registrant_handle
  validates :domain, format: { with: /\./ }
  validates :period, numericality: { less_than_or_equal_to: 10 }
end