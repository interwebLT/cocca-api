class Order < EPP::Model
  attr_accessor :currency_code, :ordered_at, :order_details

  validate do
    validate_details
  end

  def initialize params
    super

    self.order_details = (params[:order_details] || []).collect do |detail|
      case detail[:type]
      when OrderDetail::RegisterDomain::TYPE  then OrderDetail::RegisterDomain.new detail
      when OrderDetail::RenewDomain::TYPE     then OrderDetail::RenewDomain.new detail
      end
    end
  end

  def save
    return false unless valid?

    result = true

    self.order_details.each do |detail|
      response = client.create detail.command
      result = result && response.success?

      save_trid response
    end

    result
  end

  def validate_details
    if self.order_details.size == 0
      errors.add(:base, :missing_order_details)
    end
    self.order_details.each do |detail|
      unless detail.valid?
        errors.add(:base, :invalid_order_detail)
      end
    end
  end

  def order_detail= detail
    od = OrderDetail.new detail
    od.authcode = 'AUTHCODE'
    self.order_details << (od)
  end

  def as_json options = nil
    {
      id: 1,
      partner:  'partner',
      order_number: 1,
      total_price:  0.00,
      fee:  0.00,
      ordered_at: self.ordered_at,
      status: 'pending',
      currency_code:  self.currency_code,
      order_details:  self.order_details.collect { |detail| detail.as_json }
    }
  end
end
