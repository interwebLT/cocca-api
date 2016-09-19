class DomainHost < EPP::Model
  attr_accessor :domain, :name

  validates :domain,  presence: true
  validates :name,    presence: true

  def create
    return false unless valid?

    domain_host_for_add = self.check_existing_host

    unless domain_host_for_add.blank?
      new_domain_host_for_add = self.name.split(',') - domain_host_for_add
      self.name = new_domain_host_for_add.join(',')
      client.update(add_command).success?
    else
      client.update(add_command).success?
    end
  end

  def destroy
    return false unless valid?

    domain_host_for_delete = self.check_existing_host

    unless domain_host_for_delete.blank?
      self.name = domain_host_for_delete.join(',')
      client.update(remove_command).success?
    else
      return true
    end
  end

  def as_json options = nil
    {
      id:   1,
      name: self.name
    }
  end

  def add_command
    EPP::Domain::Update.new self.domain, {
      add: {
        ns: self.name.split(',')
      }
    }
  end

  def remove_command
    EPP::Domain::Update.new self.domain, {
      rem: {
        ns: self.name.split(',')
      }
    }
  end

  def check_existing_host
    partner = Partner.find_by name: self.partner

    username = partner ? partner.username : Rails.configuration.x.epp_username
    password = partner ? partner.password : Rails.configuration.x.epp_password
    host  = Rails.configuration.x.epp_host

    current_client = EPP::Client.new username, password, host

    existing_hosts = []
    domain_hosts = self.name.split(',')

    response = current_client.info EPP::Domain::Info.new self.domain
    info     = EPP::Domain::InfoResponse.new response
    current_domain_hosts_info = info.nameservers
    unless current_domain_hosts_info.nil?
      current_domain_hosts_array = current_domain_hosts_info.map{|a| a.map{|k,v|v}.join}

      domain_hosts.map{|domain_host|
        if current_domain_hosts_array.include?(domain_host)
          existing_hosts << domain_host
        end
      }
    end
    existing_hosts
  end
end
