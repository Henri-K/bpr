class Note < ActiveRecord::Base
  
  belongs_to :showing
  belongs_to :user
  
  validates_presence_of :description
  
  #Queries
  default_scope { order(created_at: :desc) }
end
