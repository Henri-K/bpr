class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes, id: :uuid  do |t|
      t.references :showing, index: true, foreign_key: true
      t.text :description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
