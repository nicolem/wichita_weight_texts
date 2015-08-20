class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   "phone"
      t.boolean  "active"
      t.integer  "next_message"
      t.timestamps null: false
    end
  end
end
