class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings, id: :uuid  do |t|
      t.string :address
      t.integer :beds
      t.integer :baths
      t.integer :parking
      t.integer :square_footage
      t.integer :year_built
      t.date :listing_date
      t.integer :asking_price
      t.integer :parking_price
      t.integer :condo_fees
      t.integer :property_tax
      t.integer :utility_cost
      t.integer :rent_amount

      t.timestamps null: false
    end
  end
end
