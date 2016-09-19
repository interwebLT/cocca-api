# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160919081819) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "dblink"

  create_table "audit_contact", id: false, force: :cascade do |t|
    t.integer  "audit_transaction", :limit=>8, :null=>false
    t.string   "audit_operation",   :limit=>1, :null=>false
    t.string   "roid",              :limit=>89, :null=>false
    t.string   "id",                :limit=>16, :null=>false
    t.string   "clid",              :limit=>16, :null=>false
    t.string   "crid",              :limit=>16, :null=>false
    t.datetime "createdate",        :null=>false
    t.string   "intpostalname",     :limit=>255
    t.string   "intpostalorg",      :limit=>255
    t.string   "intpostalstreet1",  :limit=>255
    t.string   "intpostalcity",     :limit=>255
    t.string   "intpostalsp",       :limit=>255
    t.string   "intpostalpc",       :limit=>255
    t.string   "intpostalcc",       :limit=>255
    t.string   "locpostalname",     :limit=>255
    t.string   "locpostalorg",      :limit=>255
    t.string   "locpostalstreet1",  :limit=>255
    t.string   "locpostalcity",     :limit=>255
    t.string   "locpostalsp",       :limit=>255
    t.string   "locpostalpc",       :limit=>255
    t.string   "locpostalcc",       :limit=>255
    t.string   "voice",             :limit=>64
    t.string   "fax",               :limit=>64
    t.string   "email",             :limit=>2048
    t.string   "intpostalstreet2",  :limit=>255
    t.string   "intpostalstreet3",  :limit=>255
    t.string   "locpostalstreet2",  :limit=>255
    t.string   "locpostalstreet3",  :limit=>255
    t.string   "voicex",            :limit=>64
    t.string   "faxx",              :limit=>64
  end

  create_table "audit_domain", force: :cascade do |t|
    t.integer  "audit_transaction",        :limit=>8, :null=>false
    t.string   "audit_operation",          :limit=>1, :null=>false
    t.string   "roid",                     :limit=>89, :null=>false
    t.string   "name",                     :limit=>255, :null=>false
    t.datetime "exdate",                   :null=>false
    t.string   "clid",                     :limit=>16, :null=>false
    t.string   "crid",                     :limit=>16, :null=>false
    t.datetime "createdate",               :null=>false
    t.string   "zone",                     :limit=>64, :null=>false
    t.string   "registrant",               :limit=>16
    t.string   "st_cl_deleteprohibited",   :limit=>1024
    t.string   "st_cl_hold",               :limit=>1024
    t.string   "st_cl_renewprohibited",    :limit=>1024
    t.string   "st_cl_transferprohibited", :limit=>1024
    t.string   "st_cl_updateprohibited",   :limit=>1024
    t.string   "authinfopw",               :limit=>64
    t.string   "st_pendingtransfer",       :limit=>1024
    t.string   "st_sv_deleteprohibited",   :limit=>1024
    t.string   "st_sv_hold",               :limit=>1024
    t.string   "st_sv_renewprohibited",    :limit=>1024
    t.string   "st_sv_transferprohibited", :limit=>1024
    t.string   "st_sv_updateprohibited",   :limit=>1024
  end

  create_table "audit_domain_contact", force: :cascade do |t|
    t.integer "audit_transaction", :limit=>8, :null=>false
    t.string  "audit_operation",   :limit=>1, :null=>false
    t.string  "domain_name",       :limit=>255, :null=>false
    t.string  "contact_id",        :limit=>255, :null=>false
    t.string  "type",              :limit=>16, :null=>false
  end

  create_table "audit_domain_event", force: :cascade do |t|
    t.integer  "audit_transaction", :limit=>8, :null=>false
    t.string   "audit_operation",   :limit=>1, :null=>false
    t.string   "domain_roid",       :limit=>89
    t.string   "domain_name",       :limit=>255
    t.string   "client_clid",       :limit=>16
    t.string   "event",             :limit=>20
    t.integer  "term_length"
    t.string   "term_units",        :limit=>20
    t.datetime "expiry_date"
    t.integer  "ledger_id"
    t.string   "login_username",    :limit=>16
  end

  create_table "audit_domain_host", force: :cascade do |t|
    t.integer "audit_transaction", :limit=>8, :null=>false
    t.string  "audit_operation",   :limit=>1, :null=>false
    t.string  "domain_name",       :limit=>255, :null=>false
    t.string  "host_name",         :limit=>255, :null=>false
  end

  create_table "audit_host", force: :cascade do |t|
    t.integer  "audit_transaction", :limit=>8, :null=>false
    t.string   "audit_operation",   :limit=>1, :null=>false
    t.string   "roid",              :limit=>89, :null=>false
    t.string   "name",              :limit=>255, :null=>false
    t.string   "clid",              :limit=>16, :null=>false
    t.string   "crid",              :limit=>16, :null=>false
    t.datetime "createdate",        :null=>false
  end

  create_table "audit_host_address", force: :cascade do |t|
    t.integer "audit_transaction", :limit=>8, :null=>false
    t.string  "audit_operation",   :limit=>1, :null=>false
    t.string  "host_name",         :limit=>255, :null=>false
    t.string  "ip",                :limit=>2, :null=>false
    t.string  "address",           :limit=>255, :null=>false
  end

  create_table "audit_ledger", force: :cascade do |t|
    t.integer  "audit_transaction", :limit=>8, :null=>false
    t.string   "audit_operation",   :limit=>1, :null=>false
    t.string   "client_roid",       :limit=>89, :null=>false
    t.text     "description",       :null=>false
    t.string   "currency",          :limit=>3, :null=>false
    t.decimal  "total",             :null=>false
    t.datetime "created",           :null=>false
    t.decimal  "balance",           :null=>false
    t.string   "tld",               :limit=>64, :null=>false
    t.string   "trans_type",        :limit=>64
    t.string   "domain_name",       :limit=>128
  end

  create_table "audit_master", id: false, force: :cascade do |t|
    t.integer  "audit_transaction", :limit=>8, :null=>false
    t.string   "audit_user",        :limit=>16
    t.string   "audit_login",       :limit=>16, :null=>false
    t.datetime "audit_time",        :null=>false
    t.string   "audit_ip",          :limit=>255, :null=>false
  end

  create_table "excluded_ips", force: :cascade do |t|
    t.string   "ip",         :limit=>16, :null=>false
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "excluded_partners", force: :cascade do |t|
    t.string   "name",       :limit=>64, :null=>false
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "partners", force: :cascade do |t|
    t.string   "name",       :limit=>64, :null=>false
    t.string   "password",   :limit=>255, :null=>false
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
    t.string   "token",      :limit=>32, :null=>false
  end

  create_table "registry_sync_domains", force: :cascade do |t|
    t.integer  "audit_transaction"
    t.string   "audit_operation"
    t.string   "roid"
    t.string   "name"
    t.datetime "exdate"
    t.text     "st_cl_deleteprohibited"
    t.text     "st_cl_hold"
    t.text     "st_cl_renewprohibited"
    t.text     "st_cl_transferprohibited"
    t.text     "st_cl_updateprohibited"
    t.text     "st_inactive"
    t.text     "st_ok"
    t.text     "st_pendingcreate"
    t.text     "st_pendingdelete"
    t.text     "st_pendingrenew"
    t.text     "st_pendingtransfer"
    t.text     "st_pendingupdate"
    t.text     "st_sv_deleteprohibited"
    t.text     "st_sv_hold"
    t.text     "st_sv_renewprohibited"
    t.text     "st_sv_transferprohibited"
    t.text     "st_sv_updateprohibited"
    t.string   "registrant"
    t.string   "authinfopw"
    t.string   "clid"
    t.string   "crid"
    t.datetime "createdate"
    t.string   "upid"
    t.datetime "updatedate"
    t.string   "zone"
    t.datetime "deletedate"
    t.boolean  "queued"
    t.boolean  "acknowledged"
    t.datetime "created_at",               :null=>false
    t.datetime "updated_at",               :null=>false
    t.datetime "transferdate"
  end

  create_table "registry_sync_masters", force: :cascade do |t|
    t.integer  "audit_transaction"
    t.string   "audit_user"
    t.string   "audit_login"
    t.datetime "audit_time"
    t.string   "audit_ip"
    t.boolean  "queued"
    t.boolean  "acknowledged"
    t.datetime "created_at",        :null=>false
    t.datetime "updated_at",        :null=>false
  end

  create_table "sync_logs", force: :cascade do |t|
    t.datetime "since",      :null=>false
    t.datetime "until",      :null=>false
    t.datetime "created_at", :null=>false
    t.datetime "updated_at", :null=>false
  end

  create_table "tr_ids", force: :cascade do |t|
    t.string   "tr_id"
    t.datetime "transaction_date"
    t.datetime "created_at",       :null=>false
    t.datetime "updated_at",       :null=>false
  end

end
