class DomainHost < EPP::Model
  attr_accessor :domain, :name

  validates :domain,  presence: true
  validates :name,    presence: true

  def destroy
    return false unless valid?

    client.update(delete_command).success?
  end

  def delete_command
    EPP::Domain::Update.new self.domain, {
      rem: {
        ns: [self.name]
      }
    }
  end
end
