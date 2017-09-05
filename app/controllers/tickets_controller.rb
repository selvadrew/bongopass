class TicketsController < ApplicationController 
	before_action :set_ticket, only: [:show, :edit, :update]
	before_action :authenticate_user!, except: [:show]


	def index
	end

	def show
	end

	def new 
	end

	def create 
		if @ticket.event.save
			@ticket = current_user.events.ticket.create(ticket_params)
		else
			render :new
		end
	end

	def edit
		@tickets = current_user.events.tickets
		
	end

	def update 
	end





	private
		def set_ticket 
			@ticket = Ticket.find(params[:id])
		end

		def ticket_params 
      		params.require(ticket).permit(:ticket_type, :ticket_name, :ticket_quantity, :tickt_price, :ticket_description,
                                    	  :ticket_start_date, :ticket_start_time, :ticket_end_date, :ticket_end_time)
        end


end