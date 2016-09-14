class Cocca::Ledger < ActiveRecord::Base
  establish_connection :public_cocca_db
  self.table_name = 'ledger'

  belongs_to :client, class_name: Cocca::Client, foreign_key: "client_roid"
  before_save :create_audit_master_entry

  def self.get_transaction_id_seq
    Cocca::Ledger.connection.select_value("select last_value from audit.transaction_id_seq")
    Cocca::Ledger.connection.select_value("SELECT nextval('audit.transaction_id_seq'::regclass)")
    current_sequence = Cocca::Ledger.connection.select_value("SELECT currval('audit.transaction_id_seq'::regclass)")

    current_sequence
  end

  private

  def create_audit_master_entry
    transaction_id_seq             = Cocca::Ledger.get_transaction_id_seq
    cocca_master                   = Cocca::Master.new
    cocca_master.audit_transaction = transaction_id_seq
    cocca_master.audit_user        = self.client.name
    cocca_master.audit_login       = "API"
    cocca_master.audit_time        = Time.now
    cocca_master.audit_ip          = Socket.ip_address_list.detect(&:ipv4_private?).try(:ip_address)
    cocca_master.save!
  end
end