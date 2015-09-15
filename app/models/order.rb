class Order < EPP::Model 
  attr_accessor :currency_code, :ordered_at,
                :order_details

  def save
    valid? && client.create(create_command).success?
  end

  def create_command
    EPP::Domain::Create.new self.order_details[0]['domain'], create_params
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
            "type": "domain_create",
            "price": 70.00,
            "domain": self.order_details[0]['domain'],
            "object": nil,
            "authcode": self.order_details[0]['authcode'],
            "period": self.order_details[0]['period'].to_i,
            "registrant_handle": self.order_details[0]['registrant_handle']
          }
        ]
    }
  end

  def create_params
    detail = order_details[0]
    {
      period: "#{detail['period']}y", registrant: detail['registrant'],
      auth_info: { pw: detail['authcode'] },
      contacts: { },
      nameservers: [
      ]
    }
  end
end