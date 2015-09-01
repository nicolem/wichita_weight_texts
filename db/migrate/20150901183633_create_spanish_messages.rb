class CreateSpanishMessages < ActiveRecord::Migration
  def change
    create_table :spanish_messages do |t|
      t.string "text"

      t.timestamps null: false
    end
  end
end
