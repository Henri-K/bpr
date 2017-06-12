class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.uuid :listing_id, index: true, foreign_key: true, null: false
      t.string :url, null: false
      t.string :caption

      t.timestamps null: false
    end
  end
end
