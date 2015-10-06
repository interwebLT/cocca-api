class Order < EPP::Model 
  attr_accessor :currency_code, :ordered_at, :order_details

  validate do 
    validate_details
  end

  def initialize params
    super

    self.order_details = []
    unless params[:order_details]
      return
    end
    params[:order_details].each do |detail|
      self.order_details << OrderDetail.new(detail)
    end
  end

  def save
    unless valid?
      return false
    end

    result = true
    response = nil
    commands = create_commands

    commands.each do |command|
      response = client.create(command)
      result = result && response.success?

      if response.success?
        trid = TrId.new
        trid.transaction_date = response.data.find('//domain:crDate').first.content
        trid.tr_id = response.instance_variable_get('@xml').find('/e:epp/e:response/e:trID/e:svTRID').first.content

        trid.save
      end
    end

    return result
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
    self.order_details << (OrderDetail.new detail)
  end

  def create_commands
    commands = []
    type = self.order_details.first.type
    if type == 'domain_create'
      self.order_details.each do |detail|
        commands << ( EPP::Domain::Create.new detail.domain, create_params )
      end
    elsif type == 'domain_renew'
      exp_date = '2017-01-01T00:00:00Z'
      period = self.order_details.first.period
      commands << (EPP::Domain::Renew.new self.order_details.first.domain, exp_date, "#{period}y")
    end

    commands
  end

  def as_json options=nil
    details = []
    self.order_details.each do |detail|
      details << detail.as_json
    end

    {
        id: 1,
        partner: "partner",
        order_number: 1,
        total_price: 70.00,
        fee: 0.00,
        ordered_at: self.ordered_at,
        status: "pending",
        currency_code: self.currency_code,
        order_details: details
    }
  end

  def create_params
    detail = order_details.first
    {
      period: "#{detail.period}y", registrant: detail.registrant_handle,
      auth_info: { pw: detail.authcode },
      contacts: { 
        admin: "",
        tech: "",
        billing: ""
        },
      nameservers: [
      ]
    }
  end
end