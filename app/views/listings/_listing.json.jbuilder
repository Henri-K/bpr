json.extract! listing, :id, :address, :beds, :baths, :parking, :square_footage, :year_built, :listing_date, :asking_price, :parking_price, :condo_fees, :property_tax, :utility_cost, :rent_amount, :created_at, :updated_at
json.url listing_url(listing, format: :json)
