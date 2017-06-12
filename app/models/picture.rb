class Picture < ActiveRecord::Base
  belongs_to :listing
  validates_presence_of :url
end
