class Showing < ActiveRecord::Base
  belongs_to :client
  belongs_to :listing

  validates_presence_of :listing_id
  
end
