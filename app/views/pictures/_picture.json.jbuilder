json.extract! picture, :id, :listing_id, :url, :caption, :created_at, :updated_at
json.url picture_url(picture, format: :json)
