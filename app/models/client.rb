class Client < ActiveRecord::Base
  ##Attributes and relationships
  belongs_to :agent
  has_many :showings
  has_many :listings, through: :showings
  
  enum down_payment_type: [:percent, :dollars]
  
  validates_presence_of :name
  
  accepts_nested_attributes_for :showings, 
                                :allow_destroy => true, 
                                :reject_if => :all_blank
                                
  self.per_page = 30
                                
  #Queries
  default_scope { order(created_at: :desc) }
  
  def self.search(search)
    if search
        where(['name ILIKE ?', "%#{search}%"])
    else
        all
    end
  end
  
end
