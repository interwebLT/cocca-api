class DomainHost < EPP::Model
  attr_accessor :domain, :name

  validates :domain,  presence: true
  validates :name,    presence: true

  def create
    return false unless valid?

    client.update(add_command).success?
  end

  def destroy
    return false unless valid?

    client.update(remove_command).success?
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
end
