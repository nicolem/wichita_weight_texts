class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.string :message
      t.datetime :time

      t.timestamps null: false
    end
  end
end
