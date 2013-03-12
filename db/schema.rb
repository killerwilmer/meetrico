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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120731234745) do

  create_table "activities", :force => true do |t|
    t.string   "name",                                     :null => false
    t.text     "description",                              :null => false
    t.datetime "start_date",                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "end_date"
    t.integer  "duration"
    t.integer  "green"
    t.integer  "yellow"
    t.integer  "red"
    t.text     "main_image_url"
    t.boolean  "recurrent",             :default => false, :null => false
    t.integer  "num_tickets",           :default => 0,     :null => false
    t.integer  "num_owner_tickets",     :default => 0,     :null => false
    t.integer  "table_id"
    t.integer  "num_available_tickets", :default => 0,     :null => false
  end

  create_table "admins", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carts", :force => true do |t|
    t.datetime "purchased_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_item_categories", :id => false, :force => true do |t|
    t.integer "category_id"
    t.integer "item_category_id"
  end

  add_index "categories_item_categories", ["category_id"], :name => "index_categories_item_categories_on_category_id"
  add_index "categories_item_categories", ["item_category_id"], :name => "index_categories_item_categories_on_item_category_id"

  create_table "cities", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "lat",         :null => false
    t.string   "long",        :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "configurations", :force => true do |t|
    t.string   "feature"
    t.string   "value"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coworking_spaces", :force => true do |t|
    t.string   "name"
    t.integer  "green"
    t.integer  "yellow"
    t.integer  "red"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "lat"
    t.string   "long"
    t.integer  "city_id"
    t.integer  "category_id"
    t.text     "description"
    t.text     "address"
  end

  create_table "image_coworking_spaces", :force => true do |t|
    t.integer  "image_id"
    t.integer  "coworking_space_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_tables", :force => true do |t|
    t.integer  "image_id"
    t.integer  "table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.text     "url_path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_categories", :force => true do |t|
    t.string   "name",                                                                         :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url",     :limit => 255
    t.decimal  "normal_price",                 :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "offered_price",                :precision => 10, :scale => 2, :default => 0.0
    t.string   "target_url"
  end

  create_table "item_categories_coworking_spaces", :force => true do |t|
    t.integer  "coworking_space_id", :default => 0
    t.integer  "green"
    t.integer  "yellow"
    t.integer  "red"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_category_id"
    t.integer  "num_tables",         :default => 0
  end

  create_table "line_items", :force => true do |t|
    t.decimal  "unit_price"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "table_id"
  end

  create_table "news_letter_emails", :force => true do |t|
    t.text     "email",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "news_letter_emails", ["email"], :name => "index_news_letter_emails_on_email", :unique => true

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "cart_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_verification", :default => "123", :null => false
    t.string   "express_token"
    t.string   "express_payer_id"
    t.string   "card_number"
  end

  create_table "products", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.decimal  "price"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reservations", :force => true do |t|
    t.integer  "table_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
    t.integer  "user_id"
    t.datetime "end_time"
    t.datetime "start_time"
    t.integer  "state_id",   :default => 1,     :null => false
    t.boolean  "recurrent",  :default => false, :null => false
  end

  create_table "reservations_activities", :force => true do |t|
    t.integer  "reservation_id", :default => 0
    t.integer  "activity_id",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "num_tickets",    :default => 0, :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscription_requests", :force => true do |t|
    t.string   "phone",                      :null => false
    t.integer  "city_id",                    :null => false
    t.integer  "user_id",                    :null => false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state",       :default => 1, :null => false
  end

  create_table "tables", :force => true do |t|
    t.integer  "coworking_space_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "booked"
    t.string   "name"
    t.string   "tipo",               :default => "resource"
    t.text     "observations"
    t.integer  "item_category_id",   :default => 0,          :null => false
  end

  create_table "tickets", :force => true do |t|
    t.integer  "cart_id",                       :null => false
    t.integer  "activity_id",                   :null => false
    t.integer  "user_id",                       :null => false
    t.integer  "state_id",                      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reservation_id", :default => 0, :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "bio"
    t.string   "avatar"
    t.string   "gender"
    t.boolean  "owner",                               :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
