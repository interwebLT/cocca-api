class Audit::Host < ActiveRecord::Base
  include AuditOperation

  self.table_name = :audit_host

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master

  validates :name, presence: true
  validates :audit_operation, presence: true
  validates :audit_transaction, presence: true

  alias_attribute :partner, :clid

  def host_addresses
    params = { audit_transaction: self.audit_transaction, host_name: self.name }

    result = {}

    Audit::HostAddress.where(params).order(:audit_operation).each do |record|
      key = record.address

      if result.has_key? key
        result.delete key
      else
        result[key] = record
      end
    end

    result.values
  end

  def as_json options = nil
    {
      name:     self.name
    }
  end
end
