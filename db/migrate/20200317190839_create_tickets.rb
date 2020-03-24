class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :request_number, index: true
      t.integer :sequence_number
      t.string :request_type
      t.datetime :response_due_date_time_at
      t.string :primary_service_area_code, index: true
      t.string :service_area_codes
      t.json :site_disposition, default: {}
    end
  end
end
