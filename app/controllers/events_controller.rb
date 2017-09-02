class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]


  def index
    @events = current_user.events
  end

  def show
    @photos = @event.photos
    @tickets = @event.tickets 
  end

  def new
    @event = current_user.events.build
    @event.tickets.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save

      if params[:images]
        params[:images].each do |image|
          @event.photos.create(image: image)
        end
      end

      @photos = @event.photos
      redirect_to event_path(@event), notice: "Saved..."
    else
      render :new 
    end
  end

  def edit
    if current_user.id == @event.user.id 
      @photos = @event.photos
      @tickets = @event.tickets
    else
     redirect_to root_path, notice: "You don't have permission"
   end

  end

  def update
    if @event.update(event_params)
      if params[:images]
        params[:images].each do |image|
          @event.photos.create(image: image)
        end
      end

      redirect_to event_path(@event), notice: "Updated..."

    else
      render :edit
    end
  end


  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event_title, :location, :start_date, :start_time, :end_date, :end_time,
                                    :event_description, :organizer_name, :organizer_description, :event_type,
                                    :facebook_link, :twitter_link, :instagram_link,
                                    tickets_attributes: Ticket.attribute_names.map(&:to_sym).push(:_destroy))
    end

    def ticket_params 
      params.require(:ticket).permit(:ticket_type, :ticket_name, :ticket_quantity, :ticket_price, :ticket_description,
                                    :ticket_start_date, :ticket_start_time, :ticket_end_date, :ticket_end_time)

    end



end
