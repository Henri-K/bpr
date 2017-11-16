class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:index, :new, :edit, :create, :destroy]

  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.search(params[:search]).paginate(:page => params[:page])
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @showings = @client.showings.includes(listing: :pictures)
    @showings = @showings.order("listings." + params[:order]) if params[:order]
    @showings = @showings.where('showings.compare' => true).paginate(:page => params[:page], :per_page => 3) if (params[:view] == "compare")
    @showings = @showings.paginate(:page => params[:page], :per_page => 21) if (params[:view] == "all")
    
    @dashboard_listing_set = dashboard_listing_set(@showings, @client) unless params[:view]
  end
  
  def compare
    @client = Client.find(params[:client_id])
    @showing = @client.showings.find(params[:showing_id])
    if @showing
      @showing.compare = params[:compare]
      @showing.save
    end
    respond_to do |format|
      format.html {redirect_to @client}
      format.json { head :no_content }
    end
  end
  
  def thumb
    @client = Client.find(params[:client_id])
    @showing = @client.showings.find(params[:showing_id])
    if @showing
      @showing.thumbup = params[:thumbup]
      @showing.thumbdown = params[:thumbdown]
      @showing.save
    end
    respond_to do |format|
      format.html {redirect_to @client}
      format.json { head :no_content }
    end
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render :show, status: :created, location: @client }
      else
        format.html { render :new }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clients/1
  # PATCH/PUT /clients/1.json
  def update
    respond_to do |format|
      succeess_redirect_path = URI(request.referer).path.gsub 'edit', ''
      if @client.update(client_params)
        format.html { redirect_to succeess_redirect_path, notice: 'Client was successfully updated.' }
        format.json { render :show, status: :ok, location: @client }
      else
        format.html { render URI(request.referer).path }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client.destroy
    respond_to do |format|
      format.html { redirect_to clients_url, notice: 'Client was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.require(:client).permit(:name, :email, :down_payment, :down_payment_type, :interest_rate, :amort, :agent_id, showings_attributes: [:id, :listing_id, :date, :compare, :_destroy])
    end
    
    def dashboard_listing_set(showings, client)
      
      [#Purchase price….most expansive/least
        {title: "Highest Asking Price", div_link_id: "asking", attr_label: "Asking Price: ",
        link_name: "Lowest", showings: showings.sort_by {|s| s.listing.asking_price}.reverse.take(3), 
        attr: "asking_price_str", client: nil, hidden: ""},
        {title: "Lowest Asking Price", div_link_id: "asking", attr_label: "Asking Price: ",
        link_name: "Highest", showings: showings.sort_by {|s| s.listing.asking_price}.take(3), 
        attr: "asking_price_str", client: nil, hidden: "hide-div"},
        #Condo fees….Lowest to highest 
        {title: "Highest Condo Fees", div_link_id: "condofee", attr_label: "Condo Fees: ",
        link_name: "Lowest", showings: showings.sort_by {|l| l.listing.condo_fees}.reverse.take(3), 
        attr: "condo_fees_str", client: nil, hidden: "hide-div"},
        {title: "Lowest Condo Fees", div_link_id: "condofee", attr_label: "Condo Fees: ",
        link_name: "Highest", showings: showings.sort_by {|l| l.listing.condo_fees}.take(3), 
        attr: "condo_fees_str", client: nil, hidden: ""},
        #Cash Flow…..Highest to lowest 
        {title: "Highest Cash Flow", div_link_id: "cashflow", attr_label: "Cash Flow: ",
        link_name: "Lowest", showings: showings.sort_by {|l| l.listing.cash_flow(client)}.reverse.take(3), 
        attr: "cash_flow_str", client: client, hidden: ""},
        {title: "Lowest Cash Flow", div_link_id: "cashflow", attr_label: "Cash Flow: ",
        link_name: "Highest", showings: showings.sort_by {|l| l.listing.cash_flow(client)}.take(3), 
        attr: "cash_flow_str", client: client, hidden: "hide-div"},
        #Total monthly expenses…..lowest to highest
        {title: "Highest Monthly Expense", div_link_id: "monthly", attr_label: "Monthly Expense: ",
        link_name: "Lowest", showings: showings.sort_by {|l| l.listing.total_monthly_cost(client)}.reverse.take(3), 
        attr: "total_monthly_cost_str", client: client, hidden: "hide-div"},
        {title: "Lowest Monthly Expense", div_link_id: "monthly", attr_label: "Monthly Expense: ",
        link_name: "Highest", showings: showings.sort_by {|l| l.listing.total_monthly_cost(client)}.take(3), 
        attr: "total_monthly_cost_str", client: client, hidden: ""},
        #Rent amount estimate…..Highest to lowest
        {title: "Highest Rent Estimate", div_link_id: "rent", attr_label: "Rent Estimate: ",
        link_name: "Lowest", showings: showings.sort_by {|l| l.listing.rent_amount_str}.reverse.take(3), 
        attr: "rent_amount_str", client: nil, hidden: ""},
        {title: "Lowest Rent Estimate", div_link_id: "rent", attr_label: "Rent Estimate: ",
        link_name: "Highest", showings: showings.sort_by {|l| l.listing.rent_amount_str}.take(3), 
        attr: "rent_amount_str", client: nil, hidden: "hide-div"},
        #Year built…….Newest to oldest 
        {title: "Newest Build Year", div_link_id: "rent", attr_label: "Build Year: ",
        link_name: "Oldest", showings: showings.sort_by {|l| l.listing.year_built || 1900}.reverse.take(3), 
        attr: "year_built_str", client: nil, hidden: ""},
        {title: "Oldest Build Year", div_link_id: "rent", attr_label: "Build Year: ",
        link_name: "Newest", showings: showings.sort_by {|l| l.listing.year_built || 1900}.take(3), 
        attr: "year_built_str", client: nil, hidden: "hide-div"},
        #Property taxes…..lowest to highest
        {title: "Highest Property Taxes", div_link_id: "rent", attr_label: "Property Taxes: ",
        link_name: "Lowest", showings: showings.sort_by {|l| l.listing.property_tax}.reverse.take(3), 
        attr: "property_tax_str", client: nil, hidden: ""},
        {title: "Lowest Property Taxes", div_link_id: "rent", attr_label: "Property Taxes: ",
        link_name: "Highest", showings: showings.sort_by {|l| l.listing.property_tax}.take(3), 
        attr: "property_tax_str", client: nil, hidden: "hide-div"},
        ]
    end
end
