class CreateShowings < ActiveRecord::Migration
  def change
    create_table :showings do |t|
      t.uuid :client_id, index: true, foreign_key: true, null: false
      t.uuid :listing_id, index: true, foreign_key: true, null: false
      t.date :date
      t.boolean :compare

      t.timestamps null: false
    end
  end
end
