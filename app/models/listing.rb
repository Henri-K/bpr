class Listing < ActiveRecord::Base
    has_many :pictures
    
    accepts_nested_attributes_for :pictures, 
                                  :allow_destroy => true, 
                                  :reject_if => :all_blank
    
    # Queries
    default_scope { order(created_at: :desc) }
    
    def self.search(search)
        if search
            where(['address LIKE ?', "%#{search}%"])
        else
            all
        end
    end
    
    after_initialize :init
    
    def init
      self.beds ||= 0   
      self.baths ||= 0 
      self.parking ||= 0
      self.square_footage ||= 0.0
      self.listing_date ||= Date.today
      self.asking_price ||= 0.0
      self.parking_price ||= 0.0
      self.condo_fees ||= 0.0
      self.property_tax ||= 0.0
      self.utility_cost ||= 0.0
      self.rent_amount ||= 0.0
    end
    

    #calculations
    def days_on_market
        (Date.today - listing_date).to_i
    end
    
    def no_parking_price
        if parking > 0
            asking_price - parking_price
        else
            asking_price
        end
    end
    
    def mortgage_payment(rate, amourt)
        principle = self.asking_price
        return 0 unless principle > 0
        compound = 2.0
        rate ||= 0.04
        amourt ||= 30.0
        payment_freq = 12.0
        numerator = ((1.0 + rate/compound)**(compound/payment_freq)) - 1.0
        denominator = 1.0 - ((1.0 + rate/compound)**(-amourt*compound))
        ((numerator/denominator) * principle).round(2)
    end
    
    def total_monthly_cost(mortgage_payment)
        utility_cost + condo_fees + property_tax + mortgage_payment
    end
    
    def price_per_sq_ft
        return 0 unless square_footage > 0
        no_parking_price/square_footage
    end
    
    def cash_flow(total_monthly_cost)
       rent_amount - total_monthly_cost
    end
end
