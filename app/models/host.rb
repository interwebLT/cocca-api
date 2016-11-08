class Host < EPP::Model
  attr_accessor :name, :crDate

  validates_presence_of :name

  def save
    return false unless valid?
    valid_second_level_domain = [] #pending
    host_name_array = self.name.strip.split(".")

    if host_name_array.last == "ph"
      if valid_second_level_domain.include?  host_name_array[host_name_array.length - 2]
        partner = Partner.find_by name: "dummy"
      else
        partner = Partner.find_by name: self.partner
      end
    else
      partner = Partner.find_by name: self.partner
    end

    username = partner ? partner.username : Rails.configuration.x.epp_username
    password = partner ? partner.password : Rails.configuration.x.epp_password
    host  = Rails.configuration.x.epp_host

    client = EPP::Client.new username, password, host

    response = client.create(create_command)

    self.crDate = response.data.find('//host:crDate').first.content if response.success?
    response.success?
  end

  def add_address params, ip_list
    if ip_list.blank?
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
    else
      ipv4_regEx = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
      ipv4 = []
      ipv6 = []
      ip_list.map{|address|
        if (address =~ ipv4_regEx)
          ipv4 << address
        else
          ipv6 << address
        end
      }
      if !ipv4.empty? && !ipv6.empty?
        if add_ipv4_and_ipv6 ipv4, ipv6
          return host_address_json params
        end
      else
        unless ipv6.empty?
          if add_ipv6 ipv6
            return host_address_json params
          end
        end
        unless ipv4.empty?
          if add_ipv4 ipv4
            return host_address_json params
          end
        end
      end
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

  def add_ipv4_and_ipv6 ipv4, ipv6
    client.update(add_ipv4_ipv6_command(ipv4, ipv6)).success?
  end

  def add_ipv4_ipv6_command ipv4, ipv6
    EPP::Host::Update.new self.name, {
        add: {
          addr: {
            ipv4: ipv4,
            ipv6: ipv6
          }
        }
      }
  end

  def delete_address host_name, address, ip_list
    if ip_list.blank?
      client.update(delete_address_command(host_name, address.split())).success?
    else
      success = client.update(delete_address_command(host_name, ip_list.split(","))).message
    end
  end

  def delete_address_command host_name, address
    EPP::Host::Update.new host_name, {
        rem: {
          addr: {
            ipv4: address,
            ipv6: address
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
    begin
      command   = EPP::Host::Check.new name
      response  = client.check command
      check     = EPP::Host::CheckResponse.new response

      not check.available? name
    rescue Exception => error
      if error.message == "Authentication error; EPP Login prohibited (code 2200)"
        host_zone = name.split(".").last
        if host_zone != "ph"
          return true
        else
          raise error
        end
      else
        raise error
      end
    end
  end
end
