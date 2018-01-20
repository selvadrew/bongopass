class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :sold]
  before_action :authenticate_user!, except: [:show]
  before_action :is_authorized, only: [:sold]


  def index
    @events = current_user.events
    @bongopass_purchases = Order.all.where(seller: current_user).count(:referral_id)
    @referral_id_count_array = Order.all.where(seller: current_user).group(:referral_id).where.not("referral_id" => nil).count
    @referral_count = @referral_id_count_array.values

    @reward_value_array = []
    if @referral_count 
      @referral_count.each do |referral|
        
        if referral <= 1
          amount = 0 
          @reward_value_array << amount 
        
        elsif referral == 2 
          amount = 5
          @reward_value_array << amount

        elsif referral >= 3 && referral <= 5
          amount = 10
          @reward_value_array << amount

        elsif referral >= 6 && referral <= 8
          amount = 20
          @reward_value_array << amount

        elsif referral >= 9 && referral <= 11
          amount = 30
          @reward_value_array << amount

        elsif referral >= 12 && referral <= 14
          amount = 40
          @reward_value_array << amount

        elsif referral >= 15 && referral <= 17
          amount = 50
          @reward_value_array << amount

        elsif referral >= 18 && referral <= 20
          amount = 60
          @reward_value_array << amount     

        elsif referral >= 21 && referral <= 23
          amount = 70
          @reward_value_array << amount    

        elsif referral >= 24 && referral <= 26
          amount = 80
          @reward_value_array << amount    

        elsif referral >= 27 && referral <= 29
          amount = 90
          @reward_value_array << amount          

        else referral >= 30
          amount = 100
          @reward_value_array << amount

        end
      end
    end

    @all_rewards_earned = @reward_value_array.inject(0, &:+)
  end


  def show
    @photos = @event.photos
    @tickets = @event.tickets 
    @speakers = @event.speakers
    @sponsors = @event.sponsors
    @ticket_price_min = @tickets.minimum(:ticket_price)
    @ticket_price_max = @tickets.maximum(:ticket_price)
    @bongopass_fee = 3.50

    set_meta_tags og: {   
      title:       @event.event_title,
      description: @event.event_description.html_safe,
      type:        'article',
      url:         event_url(@event),
      image:       @photos[0].image.url(:original) if @photos[0].image.url(:original).present? 
        }



  end

  def new
    @event = current_user.events.build
    @event.tickets.build
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save

      #save cover photo
      if params[:images]
        params[:images].each do |image|
          @event.photos.create(image: image)
        end
      end

      #save speaker avatars
      if params[:avatars]
        params[:avatars].each do |avatar|
          @event.speakers.build(avatar: avatar)
        end
      end

      #save sponsor logos
      if params[:logos]
        params[:logos].each do |logos|
          @event.sponsors.create(logo: logo)
        end
      end



      @photos = @event.photos
      @speakers = @event.speakers
      @sponsors = @event.sponsors
      redirect_to event_path(@event), notice: "Saved..."
    else
      render :new 
    end
  end

  def edit
    if current_user.id == @event.user.id
      @photos = @event.photos
      @tickets = @event.tickets
      @questions = @event.questions 
      @speakers = @event.speakers
      @sponsors = @event.sponsors

    else
     redirect_to root_path, notice: "You don't have permission"
   end

  end

  def update

    if @event.update(event_params)
     
     if @event.photos.length < 2
        #save cover photo
        if params[:images]
          params[:images].each do |image|
            @event.photos.create(image: image)
          end
        end 
      end


      redirect_to event_path(@event), notice: "Updated..."

    else

      render :edit
    end

  end





  def sold
    @orders = Order.all.where(seller: current_user).order("created_at DESC")
    @tickets = Ticket.all.where(event_id: @event.id)
    @event_orders = Order.joins(:ticket).where(tickets: { event_id: @event.id })
    @bongopass_purchases = Order.joins(:ticket).where(tickets: { event_id: @event.id }).count(:referral_id)
    
    @event_orders_pdf = Order.joins(:ticket).where(tickets: { event_id: @event.id }).order('LOWER(last_name)')

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Guest List",
               template: "events/sold.pdf.erb",
               locals: {:event_orders => @event_orders_pdf}
      end
    end

  end




  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:event_title, :location, :start_date, :start_time, :end_date, :end_time,
                                    :event_description, :organizer_name, :organizer_description, :event_type,
                                    :facebook_link, :twitter_link, :instagram_link, :venue, :event_currency,
                                    tickets_attributes: Ticket.attribute_names.map(&:to_sym).push(:_destroy),
                                    questions_attributes: Question.attribute_names.map(&:to_sym).push(:id, :_destroy),
                                    speakers_attributes: Speaker.attribute_names.map(&:to_sym).push(:id, :avatar, :_destroy),
                                    sponsors_attributes: Sponsor.attribute_names.map(&:to_sym).push(:id, :logo, :_destroy),
                                    images_attributes: Image.attribute_names.map(&:to_sym),
                                    photos_attributes: Photo.attribute_names.map(&:to_sym))
    end

    def ticket_params 
      params.require(:ticket).permit(:ticket_type, :ticket_name, :ticket_quantity, :ticket_price, :ticket_description,
                                    :ticket_start_date, :ticket_start_time, :ticket_end_date, :ticket_end_time)

    end

    def is_authorized
      redirect_to root_path, alert: "You don't have permission" unless current_user.id == @event.user_id
    end



end
