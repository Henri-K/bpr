class Listing < ActiveRecord::Base
    has_many :pictures
    has_many :showings
    
    accepts_nested_attributes_for :pictures, 
                                  :allow_destroy => true, 
                                  :reject_if => :all_blank
                                  
    after_initialize :init
    
    # Queries
    
    def self.search(search)
        if search
            where(['address ILIKE ?', "%#{search}%"])
        else
            all
        end
    end
    
    def set_client_defaults(client)
        default_client = {"down_payment"=> 50000, "down_payment_type"=>"dollars", "interest_rate"=>3, "amort"=>25}
        if client 
            default_client.merge! client.slice(:down_payment, :down_payment_type, :interest_rate, :amort).compact
        else
            default_client
        end
    end
    
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
    
    def self.import_key_rename
       {address: "Address",
        parking: "Number of Garage Spaces",
        beds: "Bedrs Total",
        baths: "Baths Total",
        listing_date: "Listing Contract Date",
        asking_price: "List Price"}
    end
    
    def self.process_row(row)
        create_hash = {}
        import_key_rename.each do | new_key, old_key |
            if row[old_key].present?
                create_hash[new_key] = row[old_key]
            end
        end
        if create_hash[:asking_price].present?
            create_hash[:asking_price] = create_hash[:asking_price].gsub(/\$|,|\s/, '')
        end
        if row["Address"].present?
            listing = find_by_address(row["Address"]) || new
            listing.attributes = create_hash
            listing.save!
        end
    end
    
    def self.import(file)
        begin
            if file and File.extname(file.path) == ".csv"
                CSV.foreach(file.path, headers: true, row_sep: :auto) do |row|
                    process_row(row.to_hash)
                end
                {notice: "Import Successful"}
            else
               {alert: "Import failed: Only CSV files can be imported."}  
            end
        rescue CSV::MalformedCSVError
            csv_text = File.read(file.path)
            csv_text = csv_text.gsub /\r\n/, ''
            CSV.parse(csv_text, headers: true, row_sep: :auto) do |row|
                puts row.to_hash
                process_row(row.to_hash)     
            end
            {notice: "Import Successful"}
        rescue => error
            puts "Error running script: " + error.message
            {alert: "Import Failed with error: " + error.message}
        end
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
    
    def mortgage_payment(client)
        client = set_client_defaults(client)
        net_principle = 
        if client["down_payment_type"] == "dollars"
            self.asking_price - client["down_payment"]
        else
            self.asking_price * (1.0 - client["down_payment"]/100.0)
        end
        return 0 unless net_principle > 0
        compound = 2.0
        rate = client["interest_rate"]/100.0
        amourt = client["amort"]
        payment_freq = 12.0
        numerator = ((1.0 + rate/compound)**(compound/payment_freq)) - 1.0
        denominator = 1.0 - ((1.0 + rate/compound)**(-amourt*compound))
        ((numerator/denominator) * net_principle).round(2)
    end
    
    def total_monthly_cost(client)
        (utility_cost + condo_fees + property_tax + mortgage_payment(client)).round(2)
    end
    
    def price_per_sq_ft
        return 0 unless square_footage > 0
        (no_parking_price/square_footage).round(2)
    end
    
    def cash_flow(client)
       (rent_amount - total_monthly_cost(client)).round(2)
    end
    
    def fees_count
        self.slice(:utility_cost, :condo_fees, :property_tax).compact.count
    end
    
    def square_footage_str
        square_footage.to_s + ' SQFT'
    end
    
    def days_on_market_str
        days_on_market.to_s + ' Days'
    end
    
    def asking_price_str
        '$' + asking_price.to_s  
    end
    
    def parking_price_str
        '$' + parking_price.to_s
    end
    
    def no_parking_price_str
        '$' + no_parking_price.to_s
    end
    
    def condo_fees_str
        '$' + condo_fees.to_s
    end
    
    def property_tax_str
        "$" + property_tax.to_s
    end
    
    def utility_cost_str
        "$" + utility_cost.to_s
    end    
    def mortgage_payment_str(client)
        "$" + mortgage_payment(client).to_s
    end        
    def total_monthly_cost_str(client)
        "$" + total_monthly_cost(client).to_s
    end
    def price_per_sq_ft_str
        "$" + price_per_sq_ft.to_s
    end
    def rent_amount_str
        "$" + rent_amount.to_s
    end
    def cash_flow_str(client)
        "$" + cash_flow(client).to_s
    end
    def year_built_str
        year_built.to_s
    end
end
