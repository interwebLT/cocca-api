class TransferRequest < EPP::Model
  attr_accessor :domain, :period, :authcode
  
  validates :domain, presence: true
  
  REQUEST = 'request'
  APPROVE = 'approve'
  REJECT = 'reject'
  
  def save
    return false unless valid?

    process_response client.transfer(REQUEST, create_command)
  end

  def update
    return false unless valid?

    process_response client.transfer(APPROVE, update_command)
  end
  
  def delete
    return false unless valid?
    
    process_response client.transfer(REJECT, delete_command)
  end
  
  def request_command
    EPP::Domain::Transfer.new domain, period, auth_info
  end
  
  def update_command
    EPP::Domain::Transfer.new domain
  end
  
  def delete_command
    EPP::Domain::Transfer.new domain
  end

  private
  
  def auth_info
    if authcode.blank?
      {}
    else
      {pw: authcode}
    end
  end

end