class Host < EPP::Model
  attr_accessor :name, :crDate

  validates_presence_of :name

  def save
    return false unless valid?

    response = client.create(create_command)

    self.crDate = response.data.find('//host:crDate').first.content if response.success?

    response.success?
  end

  def add_address params
    if params[:type].blank? || params[:address].blank?
      return false
    end
    if params[:type] == 'v4' && add_ipv4( params[:address] )
      return host_address_json params
    elsif params[:type] == 'v6' && add_ipv6( params[:address] )
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
    return false unless valid?

    client.update(add_ipv4_command(ipv4)).success?
  end

  def add_ipv4_command ipv4
    EPP::Host::Update.new self.name, {
        add: {
          addr: {
            ipv4: ipv4
          }
        }
      }
  end

  def add_ipv6 ipv6
    return false unless valid?

    client.update(add_ipv6_command(ipv6)).success?
  end

  def add_ipv6_command ipv6
    EPP::Host::Update.new self.name, {
        add: {
          addr: {
            ipv6: ipv6
          }
        }
      }
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

  def exists? name:
    command   = EPP::Host::Check.new name
    response  = client.check command
    check     = EPP::Host::CheckResponse.new response

    not check.available? name
  end
end
