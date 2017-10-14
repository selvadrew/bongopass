class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]


  def index
    @events = current_user.events
  end

  def show
    @photos = @event.photos
    @tickets = @event.tickets 
    @speakers = @event.speakers
    @sponsors = @event.sponsors

    set_meta_tags title: @event.event_title,
            site: 'Bongo Pass',
            reverse: true,
            description:        @event.organizer_name, 
            twitter: {
              card:             "summary",
              site:             "@event",
              title:            @event.event_title,
              description:      @event.organizer_name,
              image:            "https://d1vc1zztydspts.cloudfront.net/attachments/57f8368ad546f79c078326455e97f4d761e7e5a0/store/61a538d65a951acd00f8e2011c143ffd7c68ff33c94117803c47f5561eba/8-2.jpg"
            },
            og: {
              title:            @event.event_title,
              description:      @event.organizer_name,
              type:             'article',
              url:              event_url(@event),
              image:            @photos[0].image.url(:original)
            }#,
            #alternate: [
            #  { href: 'http://example.fr/base/url', hreflang: 'fr' },
            #  { href: 'http://example.com/feed.rss', type: 'application/rss+xml', title: 'RSS' }
            
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

      #save speaker avatars




      #save sponsor logos


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





end
