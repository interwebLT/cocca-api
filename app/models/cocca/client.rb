class Cocca::Client < ActiveRecord::Base
  establish_connection :public_cocca_db
  self.table_name = 'client'
  has_many :ledgers, class_name: Cocca::Ledger, foreign_key: "client_roid"
end