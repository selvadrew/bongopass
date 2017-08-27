class RegistrationsController <Devise::RegistrationsController 
	#this allows users to edit their profile without needing to re-enter their current password 
	protected
		def update_resource(resource, params)
			resource.update_without_password(params)
		end
end
