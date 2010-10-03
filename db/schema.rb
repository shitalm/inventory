# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101003130523) do

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense_entities", :force => true do |t|
    t.string   "name"
    t.string   "entity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expense_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "expenses", :force => true do |t|
    t.integer  "expense_type_id"
    t.date     "date"
    t.float    "amount"
    t.integer  "expense_entity_id"
    t.string   "expense_entity_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "mrp"
  end

  create_table "items_parts", :id => false, :force => true do |t|
    t.integer  "item_id"
    t.integer  "part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_orders", :force => true do |t|
    t.integer  "itemCount"
    t.integer  "deliveredCount"
    t.integer  "purchase_order_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
    t.float    "total_price"
  end

  create_table "parts", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "payable_id"
    t.string   "payable_type"
    t.integer  "payment_type_id"
    t.float    "amount"
    t.date     "date"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_order_parts", :force => true do |t|
    t.integer  "purchase_order_id"
    t.integer  "part_id"
    t.integer  "purchased"
    t.integer  "delivered"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_orders", :force => true do |t|
    t.date     "purchaseDate"
    t.string   "description"
    t.integer  "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
    t.text     "details"
  end

  create_table "sale_order_lines", :force => true do |t|
    t.integer  "sale_order_id"
    t.integer  "item_id"
    t.integer  "item_count"
    t.integer  "delivered_count"
    t.float    "unit_price"
    t.float    "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_order_parts", :force => true do |t|
    t.integer  "sale_order_id"
    t.integer  "part_id"
    t.integer  "sold"
    t.integer  "delivered"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sale_orders", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.date     "sale_date"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "details"
  end

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
