class Order < EPP::Model 
  attr_accessor :currency_code, :ordered_at, :order_details

  validate do 
    validate_details
  end

  def initialize params
    super

    self.order_details = []
    params[:order_details].each do |detail|
      self.order_details << OrderDetail.new(detail)
    end
  end

  def save
    valid? && client.create(create_command).success?
  end

  def validate_details
    self.order_details.each do |detail|
      unless detail.valid?
        errors.add(:base, :invalid_order_detail)
      end
    end
  end

  def order_detail= detail
    self.order_details << (OrderDetail.new detail)
  end

  def create_command
    type = self.order_details[0].type
    if type == 'domain_create'
      EPP::Domain::Create.new self.order_details[0].domain, create_params
    elsif type == 'domain_renew'
      exp_date = '2017-01-01T00:00:00Z'
      period = self.order_details[0].period
      EPP::Domain::Renew.new self.order_details[0].domain, exp_date, "#{period}y"
    end
  end

  def as_json options=nil
    {
        "id": 1,
        "partner": "partner",
        "order_number": 1,
        "total_price": 70.00,
        "fee": 0.00,
        "ordered_at": self.ordered_at,
        "status": "pending",
        "currency_code": self.currency_code,
        "order_details": [
          {
            "type": self.order_details[0].type,
            "price": 70.00,
            "domain": self.order_details[0].domain,
            "object": nil,
            "authcode": self.order_details[0].authcode,
            "period": self.order_details[0].period.to_i,
            "registrant_handle": self.order_details[0].registrant_handle
          }
        ]
    }
  end

  def create_params
    detail = order_details[0]
    {
      period: "#{detail.period}y", registrant: detail.registrant_handle,
      auth_info: { pw: detail.authcode },
      contacts: { },
      nameservers: [
      ]
    }
  end
end