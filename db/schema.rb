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

ActiveRecord::Schema.define(version: 20150514185319) do

  create_table "accounts", force: true do |t|
    t.string "name"
    t.string "phone1"
    t.string "phone2"
    t.string "fax"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address_1_line_1"
    t.string "address_1_line_2"
    t.string "address_1_line_3"
    t.string "address_1_city"
    t.string "address_1_state"
    t.string "address_1_zip"
    t.string "address_1_country"
    t.text   "notes"
    t.string "bank_1_name"
    t.string "bank_1_aba"
    t.string "bank_1_account"
    t.string "bank_1_swift_code"
    t.string "bank_1_attention"
  end

  create_table "addresses", force: true do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "line3"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
  end

  create_table "banks", force: true do |t|
    t.string   "name"
    t.string   "aba"
    t.string   "swift"
    t.string   "attention"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "line1"
    t.string   "line2"
    t.string   "line3"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "account_number"
  end

  create_table "certificate_of_origins", force: true do |t|
    t.string   "hs_code"
    t.string   "treatment"
    t.string   "place_of_initial_receipt"
    t.string   "port_of_loading"
    t.string   "forwarding_agent"
    t.string   "initial_carriage_by"
    t.string   "vessel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.text     "routing_instructions"
  end

  create_table "commissions", force: true do |t|
    t.decimal  "percent"
    t.integer  "cents_per_pound"
    t.integer  "cents"
    t.integer  "order_id"
    t.integer  "broker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commodities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contracts", force: true do |t|
    t.string   "buyer_contract"
    t.string   "buyer_po"
    t.string   "seller_contract"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "buyer_id"
    t.integer  "seller_id"
    t.text     "payment_terms"
    t.text     "remarks"
    t.string   "ship_date_note"
    t.integer  "acting_seller_id"
  end

  create_table "delivery_locations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_orders", force: true do |t|
    t.integer  "document_id"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invoice_line_items", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "amount_cents"
    t.integer  "order_id"
    t.integer  "invoice_id"
  end

  create_table "invoices", force: true do |t|
    t.integer  "order_id"
    t.integer  "payee_id"
    t.integer  "payer_id"
    t.integer  "address_id"
    t.integer  "bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invoice_number"
    t.boolean  "hide_commission"
    t.boolean  "show_bank_wire_info"
  end

  create_table "item_size_indicators", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "commodity_id"
    t.integer  "size_id"
    t.integer  "variety_id"
    t.integer  "grade_id"
    t.integer  "origin_id"
    t.integer  "shell_id"
  end

  create_table "order_line_items", force: true do |t|
    t.integer  "item_id"
    t.integer  "price_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_id"
    t.integer  "quote_line_item_id"
    t.integer  "weight_id"
    t.integer  "item_size_indicator_id"
    t.decimal  "pack_weight_pounds"
    t.integer  "pack_count"
    t.integer  "pack_type_id"
    t.string   "season"
  end

  create_table "orders", force: true do |t|
    t.date     "ship_date"
    t.date     "last_received_date"
    t.date     "doc_cut_off"
    t.date     "estimated_arrival_date"
    t.string   "shipping_company"
    t.string   "voyage"
    t.string   "port_of_discharge"
    t.string   "vessel"
    t.string   "ship_in_name_of"
    t.string   "booking_number"
    t.string   "commodity"
    t.string   "shipping_company_reference_number"
    t.string   "automated_export_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contract_id"
    t.integer  "load_number"
    t.string   "consignee"
    t.text     "shipping_instructions"
    t.string   "line1"
    t.string   "line2"
    t.string   "line3"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "container_number"
    t.string   "seal_number"
    t.string   "gross_weight"
    t.date     "container_out"
    t.date     "docs_in"
    t.date     "docs_out"
    t.string   "invoice_number"
    t.date     "expected_pay"
    t.date     "received_pay"
    t.string   "amount_received"
    t.string   "container_size"
    t.text     "ship_delivery"
    t.text     "ship_pick_up"
    t.integer  "bank_id"
    t.integer  "address_id"
    t.decimal  "discount_percent"
    t.integer  "discount_cents_per_pound"
    t.integer  "discount_cents"
    t.string   "buyer_po"
    t.integer  "mail_to_id"
    t.string   "gross_truck_weight"
    t.string   "truck_gross_weight"
  end

  create_table "origins", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pack_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quote_line_items", force: true do |t|
    t.integer  "quote_id"
    t.integer  "item_id"
    t.integer  "price_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_size_indicator_id"
    t.decimal  "pack_weight_pounds",     precision: 16, scale: 2
    t.integer  "pack_type_id"
    t.integer  "weight_id"
    t.integer  "pack_count"
  end

  create_table "quotes", force: true do |t|
    t.integer  "seller_id"
    t.integer  "contract_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "remarks", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shells", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sizes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "terms", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "varieties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weights", force: true do |t|
    t.string   "weight_unit_of_measure"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
