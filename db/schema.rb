# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_17_191746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "excavators", force: :cascade do |t|
    t.bigint "ticket_id"
    t.string "company_name"
    t.jsonb "address", default: {}
    t.boolean "crew_on_site", default: false
    t.index ["ticket_id"], name: "index_excavators_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "request_number"
    t.integer "sequence_number"
    t.string "request_type"
    t.datetime "response_due_date_time_at"
    t.string "primary_service_area_code"
    t.string "service_area_codes"
    t.json "site_disposition", default: {}
    t.index ["primary_service_area_code"], name: "index_tickets_on_primary_service_area_code"
    t.index ["request_number"], name: "index_tickets_on_request_number"
  end

  add_foreign_key "excavators", "tickets"
end
