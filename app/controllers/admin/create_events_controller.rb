class Admin::CreateEventsController < Admin::BaseController
	
	def index 
		@create_events = User.all 
	end

end