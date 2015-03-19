class Initial < ActiveRecord::Migration
  def change
    create_table :sync_logs do |t|
      t.timestamp :since, null: false
      t.timestamp :until, null: false

      t.timestamps null: false
    end

    create_table :audit_master, id: false, primary_key: :audit_transaction do |t|
      t.integer   :audit_transaction, null: false
      t.string    :audit_user,                      limit: 16
      t.string    :audit_login,       null: false,  limit: 16
      t.timestamp :audit_time,        null: false
      t.string    :audit_ip,          null: false,  limit: 255
    end

    create_table :audit_ledger do |t|
      t.integer   :audit_transaction, null: false
      t.string    :audit_operation,   null: false,  limit: 1
      t.string    :client_roid,       null: false,  limit: 89
      t.text      :description,       null: false,  limit: 3
      t.string    :currency,          null: false,  limit: 3
      t.decimal   :total,             null: false
      t.timestamp :created,           null: false
      t.decimal   :balance,           null: false
      t.string    :tld,               null: false,  limit: 64
    end

    create_table :audit_domain do |t|
      t.integer   :audit_transaction,         null: false
      t.string    :audit_operation,           null: false,  limit: 1
      t.string    :roid,                      null: false,  limit: 89
      t.string    :name,                      null: false,  limit: 255
      t.timestamp :exdate,                    null: false
      t.string    :clid,                      null: false,  limit: 16
      t.string    :crid,                      null: false,  limit: 16
      t.timestamp :createdate,                null: false
      t.string    :zone,                      null: false,  limit: 64
      t.string    :registrant,                              limit: 16
      t.string    :st_cl_deleteprohibited,                  limit: 1024
      t.string    :st_cl_hold,                              limit: 1024
      t.string    :st_cl_renewprohibited,                   limit: 1024
      t.string    :st_cl_transferprohibited,                limit: 1024
      t.string    :st_cl_updateprohibited,                  limit: 1024
    end

    create_table :audit_contact, id: false do |t|
      t.integer   :audit_transaction, null: false
      t.string    :audit_operation,   null: false,  limit: 1
      t.string    :roid,              null: false,  limit: 89
      t.string    :id,                null: false,  limit: 16
      t.string    :clid,              null: false,  limit: 16
      t.string    :crid,              null: false,  limit: 16
      t.timestamp :createdate,        null: false
      t.string    :intpostalname,                   limit: 255
      t.string    :intpostalorg,                    limit: 255
      t.string    :intpostalstreet1,                limit: 255
      t.string    :intpostalcity,                   limit: 255
      t.string    :intpostalsp,                     limit: 255
      t.string    :intpostalpc,                     limit: 255
      t.string    :intpostalcc,                     limit: 255
      t.string    :locpostalname,                   limit: 255
      t.string    :locpostalorg,                    limit: 255
      t.string    :locpostalstreet1,                limit: 255
      t.string    :locpostalcity,                   limit: 255
      t.string    :locpostalsp,                     limit: 255
      t.string    :locpostalpc,                     limit: 255
      t.string    :locpostalcc,                     limit: 255
      t.string    :voice,                           limit: 64
      t.string    :fax,                             limit: 64
      t.string    :email,                           limit: 2048
    end

    create_table :audit_host do |t|
      t.integer   :audit_transaction, null: false
      t.string    :audit_operation,   null: false,  limit: 1
      t.string    :roid,              null: false,  limit: 89
      t.string    :name,              null: false,  limit: 255
      t.string    :clid,              null: false,  limit: 16
      t.string    :crid,              null: false,  limit: 16
      t.timestamp :createdate,        null: false
    end

    create_table :audit_domain_event do |t|
      t.integer   :audit_transaction, null: false
      t.string    :audit_operation,   null: false,  limit: 1
      t.string    :domain_roid,                     limit: 89
      t.string    :domain_name,                     limit: 255
      t.string    :client_clid,                     limit: 16
      t.string    :event,                           limit: 20
      t.integer   :term_length
      t.string    :term_units,                      limit: 20
      t.timestamp :expiry_date
      t.integer   :ledger_id
      t.string    :login_username,                  limit: 16
    end

    create_table :audit_domain_contact do |t|
      t.integer :audit_transaction, null: false
      t.string  :audit_operation,   null: false,  limit: 1
      t.string  :domain_name,       null: false,  limit: 255
      t.string  :contact_id,        null: false,  limit: 255
      t.string  :type,              null: false,  limit: 16
    end

    create_table :audit_domain_host do |t|
      t.integer :audit_transaction, null: false
      t.string  :audit_operation,   null: false, limit: 1
      t.string  :domain_name,       null: false, limit: 255
      t.string  :host_name,         null: false, limit: 255
    end

    create_table :audit_host_address do |t|
      t.integer :audit_transaction, null: false
      t.string  :audit_operation,   null: false, limit: 1
      t.string  :host_name,         null: false, limit: 255
      t.string  :ip,                null: false, limit: 2
      t.string  :address,           null: false, limit: 255
    end
  end
end
