module ApplicationHelper
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		if user.image 
			user.image
		else
		"https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"

		end
	end


	def link_to_add_row(name, f, association, **args)
		new_object = f.object.send(association).klass.new 
		id = new_object.object_id 
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize, f: builder) 
		end
		link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")}) 
	end




end




