class OrderDetail 
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :type, :domain, :period, :authcode, :registrant_handle

  validates_presence_of :domain, :authcode, :registrant_handle
  validates :domain, format: { with: /\./ }
  validates :period, numericality: { less_than_or_equal_to: 10 }

  def as_json
    {
      "type": type,
      "price": 70.00,
      "domain": domain,
      "object": nil,
      "authcode": authcode,
      "period": period.to_i,
      "registrant_handle": registrant_handle
    }
  end
end