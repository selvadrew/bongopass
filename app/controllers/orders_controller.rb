class OrdersController < ApplicationController
  include CurrentReferral 
  #before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :already_purchased, only: [:create]
  before_action :calculate_rewards, only: [:purchases, :create, :new]
  

  def sales 
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end


  def purchases 
    
  end



  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
   # @bongopass_fee =3.50
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @ticket = Ticket.find(params[:ticket_id])
    @bongo_fee = 0.99
    @order.referral_id = session[:referral]
    @referral = Referral.find(session[:referral]) if session[:referral]

    #calculate how much rewards are used 
    if @net_rewards_available >= @ticket.ticket_price
      @order.rewards_used = @ticket.ticket_price 
    elsif @net_rewards_available == 0 
      @order.rewards_used = 0 
    else 
      @order.rewards_used = @net_rewards_available 
    end

    @payment_amount = (@ticket.ticket_price - @order.rewards_used) + @ticket.event.reward_fee + @bongo_fee

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

    @order.bongo_fee = 0.99 
    @bongo_fee = 0.99
    @order.stripe_fee = (@ticket.ticket_price + @ticket.event.reward_fee + @bongo_fee) * 0.029 + 0.3 
    @order.organizer_set_reward = @ticket.event.reward_fee

    
    

    #calculate how much rewards are used 
    if @net_rewards_available >= @ticket.ticket_price
      @order.rewards_used = @ticket.ticket_price 
    elsif @net_rewards_available == 0 
      @order.rewards_used = 0 
    else 
      @order.rewards_used = @net_rewards_available 
    end

    
    @referral = Referral.find(session[:referral]) if session[:referral]

    if @referral 
      if @referral.order.ticket.event_id == @ticket.event_id 
        @order.referral_id = session[:referral]
      end
    end

    if @referral && @referral.order.ticket.event_id == @ticket.event_id
        @order.organizer_sales = @ticket.ticket_price - @order.stripe_fee
    else
      @order.organizer_sales = @ticket.ticket_price + @ticket.event.reward_fee - @order.stripe_fee
    end
  


unless @ticket.ticket_quantity == 0 
  Stripe.api_key = ENV["STRIPE_API_KEY"]
     token = params[:stripeToken]
 
     begin
       charge = Stripe::Charge.create(
         :amount => ((@ticket.ticket_price * 100).floor + (@ticket.event.reward_fee * 100).floor - (@order.rewards_used * 100).floor) + (@order.bongo_fee * 100).floor,
         :currency => @ticket.event.event_currency,
         :description => "Example charge",
         :source => token
         #:receipt_email => "andrew.selvadurai6@gmail.com",
         #:destination => {
         # :amount => (@ticket.ticket_price * 100).floor - (@order.stripe_fee * 100).floor,
         # :account => @ticket.event.user.merchant_id 
           #}
         )

       if charge
          OrderMailer.send_email_to_buyer(@order.buyer, @ticket.event).deliver_later
        end
       flash[:notice] = "Thanks for ordering!"

        rescue Stripe::CardError => e
        flash[:error] = e.message
        return redirect_to new_ticket_order_path

     end
end

       respond_to do |format|
            if @order.save
              format.html { redirect_to mypass_referral_path(@order.referral) }
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
      params.require(:order).permit(:first_name, :last_name)
    end

    def update_inventory
      @ticket.ticket_quantity - 1 
    end

    #People can still buy another type of ticket for that event if the event has multiple tickets 
    def already_purchased 
      @ticket = Ticket.find(params[:ticket_id])
      unless Order.joins(:ticket).where(buyer_id: current_user.id).where(ticket_id: @ticket.id).blank?
        redirect_to new_ticket_order_path, notice: "You can only purchase one Pass for this event"
      end
    end


    def calculate_rewards
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
    @all_rewards_used = 0 
    @net_rewards_available = 0


    if @orders 
      @rewards_used_array = []
      @orders.each do |order|
        ching = order.rewards_used
        @rewards_used_array << ching 
      end

      @all_rewards_used = @rewards_used_array.inject(0, &:+)
    end

    #GETS ALL THE REFERRAL_IDS THAT BELONG TO THE USER, SINCE @ORDERS ARE THE USERS ORDERS
    if @orders 
    @referral_id = []
      @orders.each do |order|
        ting = order.referral.id 
        @referral_id << ting 
      end
    

    #COUNTS THE NUMBER OF TIMES THAT REFERRAL ID IS USED
    @something = Order.where(referral_id: @referral_id).group(:referral_id).count

    #TAKES THE REFERRAL ID AND COUNT AND MULTIPLIES IT BY WHATEVER THE REWARD FEE IS FOR THAT EVENT
    @reward_value_array = []
    if @something 

      @something.each do |id, count|
        amount = Referral.where(id: id).first.order.organizer_set_reward * count 
        @reward_value_array << amount

      end
    end

    @all_rewards_earned = @reward_value_array.inject(0, &:+)

    @net_rewards_available = @all_rewards_earned - @all_rewards_used
  end

  end




end







