class DomainHost < EPP::Model
  attr_accessor :domain, :name

  def destroy
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
