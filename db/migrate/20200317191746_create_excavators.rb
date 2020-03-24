class CreateExcavators < ActiveRecord::Migration[6.0]
  def change
    create_table :excavators do |t|
      t.references :ticket, index: true
      t.string :company_name
      t.jsonb :address, default: {}
      t.boolean :crew_on_site, default: false
    end
  end
end
