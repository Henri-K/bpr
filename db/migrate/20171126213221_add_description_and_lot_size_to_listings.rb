class AddDescriptionAndLotSizeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :description, :text
    add_column :listings, :lot_size, :integer
  end
end
