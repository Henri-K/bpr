class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :name, null: false
      t.string :avatar
      t.string :email

      t.timestamps null: false
    end
  end
end
