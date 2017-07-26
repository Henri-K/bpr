class Showing < ActiveRecord::Base
  belongs_to :client
  belongs_to :listing
  
  validates_presence_of :client_id
  validates_presence_of :listing_id
  
  default_scope { order(date: :desc) }
end
