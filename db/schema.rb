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

ActiveRecord::Schema.define(version: 20150324025313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audit_contact", id: false, force: :cascade do |t|
    t.integer  "audit_transaction",              null: false
    t.string   "audit_operation",   limit: 1,    null: false
    t.string   "roid",              limit: 89,   null: false
    t.string   "id",                limit: 16,   null: false
    t.string   "clid",              limit: 16,   null: false
    t.string   "crid",              limit: 16,   null: false
    t.datetime "createdate",                     null: false
    t.string   "intpostalname",     limit: 255
    t.string   "intpostalorg",      limit: 255
    t.string   "intpostalstreet1",  limit: 255
    t.string   "intpostalcity",     limit: 255
    t.string   "intpostalsp",       limit: 255
    t.string   "intpostalpc",       limit: 255
    t.string   "intpostalcc",       limit: 255
    t.string   "locpostalname",     limit: 255
    t.string   "locpostalorg",      limit: 255
    t.string   "locpostalstreet1",  limit: 255
    t.string   "locpostalcity",     limit: 255
    t.string   "locpostalsp",       limit: 255
    t.string   "locpostalpc",       limit: 255
    t.string   "locpostalcc",       limit: 255
    t.string   "voice",             limit: 64
    t.string   "fax",               limit: 64
    t.string   "email",             limit: 2048
    t.string   "intpostalstreet2",  limit: 255
    t.string   "intpostalstreet3",  limit: 255
    t.string   "locpostalstreet2",  limit: 255
    t.string   "locpostalstreet3",  limit: 255
  end

  create_table "audit_domain", force: :cascade do |t|
    t.integer  "audit_transaction",                     null: false
    t.string   "audit_operation",          limit: 1,    null: false
    t.string   "roid",                     limit: 89,   null: false
    t.string   "name",                     limit: 255,  null: false
    t.datetime "exdate",                                null: false
    t.string   "clid",                     limit: 16,   null: false
    t.string   "crid",                     limit: 16,   null: false
    t.datetime "createdate",                            null: false
    t.string   "zone",                     limit: 64,   null: false
    t.string   "registrant",               limit: 16
    t.string   "st_cl_deleteprohibited",   limit: 1024
    t.string   "st_cl_hold",               limit: 1024
    t.string   "st_cl_renewprohibited",    limit: 1024
    t.string   "st_cl_transferprohibited", limit: 1024
    t.string   "st_cl_updateprohibited",   limit: 1024
  end

  create_table "audit_domain_contact", force: :cascade do |t|
    t.integer "audit_transaction",             null: false
    t.string  "audit_operation",   limit: 1,   null: false
    t.string  "domain_name",       limit: 255, null: false
    t.string  "contact_id",        limit: 255, null: false
    t.string  "type",              limit: 16,  null: false
  end

  create_table "audit_domain_event", force: :cascade do |t|
    t.integer  "audit_transaction",             null: false
    t.string   "audit_operation",   limit: 1,   null: false
    t.string   "domain_roid",       limit: 89
    t.string   "domain_name",       limit: 255
    t.string   "client_clid",       limit: 16
    t.string   "event",             limit: 20
    t.integer  "term_length"
    t.string   "term_units",        limit: 20
    t.datetime "expiry_date"
    t.integer  "ledger_id"
    t.string   "login_username",    limit: 16
  end

  create_table "audit_domain_host", force: :cascade do |t|
    t.integer "audit_transaction",             null: false
    t.string  "audit_operation",   limit: 1,   null: false
    t.string  "domain_name",       limit: 255, null: false
    t.string  "host_name",         limit: 255, null: false
  end

  create_table "audit_host", force: :cascade do |t|
    t.integer  "audit_transaction",             null: false
    t.string   "audit_operation",   limit: 1,   null: false
    t.string   "roid",              limit: 89,  null: false
    t.string   "name",              limit: 255, null: false
    t.string   "clid",              limit: 16,  null: false
    t.string   "crid",              limit: 16,  null: false
    t.datetime "createdate",                    null: false
  end

  create_table "audit_host_address", force: :cascade do |t|
    t.integer "audit_transaction",             null: false
    t.string  "audit_operation",   limit: 1,   null: false
    t.string  "host_name",         limit: 255, null: false
    t.string  "ip",                limit: 2,   null: false
    t.string  "address",           limit: 255, null: false
  end

  create_table "audit_ledger", force: :cascade do |t|
    t.integer  "audit_transaction",            null: false
    t.string   "audit_operation",   limit: 1,  null: false
    t.string   "client_roid",       limit: 89, null: false
    t.text     "description",                  null: false
    t.string   "currency",          limit: 3,  null: false
    t.decimal  "total",                        null: false
    t.datetime "created",                      null: false
    t.decimal  "balance",                      null: false
    t.string   "tld",               limit: 64, null: false
  end

  create_table "audit_master", id: false, force: :cascade do |t|
    t.integer  "audit_transaction",             null: false
    t.string   "audit_user",        limit: 16
    t.string   "audit_login",       limit: 16,  null: false
    t.datetime "audit_time",                    null: false
    t.string   "audit_ip",          limit: 255, null: false
  end

  create_table "sync_logs", force: :cascade do |t|
    t.datetime "since",      null: false
    t.datetime "until",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
