class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients, id: :uuid do |t|
      t.string :name, null: false
      t.string :email
      t.integer :down_payment
      t.integer :down_payment_type
      t.integer :interest_rate
      t.integer :amort
      t.references :agent, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end