class Host < EPP::Model
  attr_accessor :name, :crDate

  validates_presence_of :name

  def save
    unless valid? 
      return false
    end
    result = client.create(create_command)
    unless result.success?
      return false
    end
    self.crDate = result.data.find('//host:crDate').first.content   
    return true
  end

  def add_address params
    if params[:type] == 'v4' && add_ipv4( params[:address] )
      return host_address_json params
    else 
      return false
    end
  end

  def host_address_json params
    t = Time.now.utc
    {
      :address => params[:address], 
      :created_at => t, 
      :id => 1, 
      :type => params[:type], 
      :updated_at => t
    }
  end

  def add_ipv4 ipv4
    valid? && client.update(add_ipv4_command ipv4).success?
  end

  def add_ipv4_command ipv4
    EPP::Host::Update.new self.name, { ipv4: ipv4 }
  end

  def create_command
    EPP::Host::Create.new self.name
  end

  def as_json options=nil
    {
      id: 1,
      partner: 'partner',
      name: self.name,
      host_addresses: [],
      created_at: self.crDate,
      updated_at: self.crDate
    }
  end
end