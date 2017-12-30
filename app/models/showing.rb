class Showing < ActiveRecord::Base
  belongs_to :client
  belongs_to :listing
  has_many :notes, :dependent => :destroy

  validates_presence_of :listing_id
  
end
