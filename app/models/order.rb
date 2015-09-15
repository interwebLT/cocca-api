class Order < EPP:Model 
  def save
    valid? && client.create(create_command).success?
  end

  def create_command
    EPP::Contact::Create.new self.handle, create_params
  end

  def as_json
    {
      
    }
  end

  def create_params
    {
    }
  end
end