class SpeakersController <ApplicationController 
	def destroy
		@speaker = Speaker.find(params[:id])
		event = @speaker.event

		@speaker.destroy
		@speakers = Speaker.where(event_id: event.id)

		respond_to :js
	end
end
