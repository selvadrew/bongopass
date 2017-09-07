class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def sales 
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
  end

  def purchases 
    @orders = Order.all.where(buyer: current_user).order("created_at DESC")
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


end
