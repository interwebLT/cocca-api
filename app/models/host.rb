class Host < EPP::Model
  attr_accessor :name, :crDate

  def save
    unless valid?
      return false
    end
    result = client.create(create_command)
    self.crDate = result.data.find('//host:crDate').first.content   
    return result.success?
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