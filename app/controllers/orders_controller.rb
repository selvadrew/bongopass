class OrdersController < ApplicationController
  include CurrentReferral 
  #before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :already_purchased, only: [:create]
  

  def sales 
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases 
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")

    #GETS ALL THE REFERRAL_IDS THAT BELONG TO THE USER, SINGE @ORDERS ARE THE USERS ORDERS
    @referral_id = []
    if @orders 
      @orders.each do |order|
        ting = order.referral.id 
        @referral_id << ting 
      end
    end

    #COUNTS THE NUMBER OF TIMES THAT REFERRAL ID IS USED
    @something = Order.where(referral_id: @referral_id).group(:referral_id).count
    @referral_count = @something.values

    #TAKES THE REFERRAL COUNT AND CALCULATES THE DOLLAR VALUE OF REWARDS FOR EACH EVENT 
    @reward_value = []
    if @referral_count 
      @referral_count.each do |referral|
        
        if referral <= 1
          amount = 0 
          @reward_value << amount 
        
        elsif referral == 2 
          amount = 5
          @reward_value << amount

        elsif referral >= 3 && referral <= 5
          amount = 10
          @reward_value << amount

        elsif referral >= 6 && referral <= 9
          amount = 20
          @reward_value << amount

        elsif referral >= 10 && referral <= 24
          amount = 35
          @reward_value << amount

        elsif referral >= 25
          amount = 100
          @reward_value << amount

        end
      end
    end

  end



  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @ticket = Ticket.find(params[:ticket_id])
    @order.referral_id = session[:referral]
    @referral = Referral.find(session[:referral]) if session[:referral]
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @ticket = Ticket.find(params[:ticket_id])
    @seller = @ticket.event.user 

    @order.ticket_id = @ticket.id 
    @order.buyer_id = current_user.id 
    @order.seller_id = @seller.id 
    
    @referral = Referral.find(session[:referral]) if session[:referral]

    if @referral 
      if @referral.order.ticket.event_id == @ticket.event_id 
        @order.referral_id = session[:referral]
      end
    end
  
  if @ticket.ticket_quantity > 0
    @ticket.ticket_quantity = update_inventory
    @ticket.save
  end

  Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :amount => (@ticket.ticket_price * 100).floor,
        :currency => "cad",
        :source => token
        )
      flash[:notice] = "Thanks for ordering!"
    rescue Stripe::CardError => e
      flash[:danger] = e.message

    end


    respond_to do |format|
      if @order.save
        format.html { redirect_to root_url }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
      end
    end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:address, :city, :province)
    end

    def update_inventory
      @ticket.ticket_quantity - 1 
    end

    #People can still buy another type of ticket for that event if the event has multiple tickets 
    def already_purchased 
      @ticket = Ticket.find(params[:ticket_id])
      if Order.joins(:ticket).where(buyer_id: current_user.id).where(ticket_id: @ticket.id)
        redirect_to new_ticket_order_path, notice: "You can only purchase one ticket for this event"
      end

    end

end







