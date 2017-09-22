module ApplicationHelper
	def avatar_url(user)
		gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		if user.image 
			user.image
		else
		"https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"

		end
	end


	def link_to_add_row_t(name, f, association, **args)
		new_object = f.object.send(association).klass.new 
		id = new_object.object_id 
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize, f: builder) 
		end
		link_to(name, '#', class: "add_fields " + args[:class], data: {id: id, fields: fields.gsub("\n", "")}) 
		
	end

	def link_to_add_row_q(name, f, association, **args)
		new_object = f.object.send(association).klass.new 
		id = new_object.object_id 
		fieldsq = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize, f: builder) 
		end
		link_to(name, '#', class: "add_fieldsq " + args[:class], data: {id: id, fieldsq: fieldsq.gsub("\n", "")}) 
	end

	def link_to_add_row_speaker(name, f, association, **args)
		new_object = f.object.send(association).klass.new 
		id = new_object.object_id 
		fieldss = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize, f: builder) 
		end
		link_to(name, '#', class: "add_fieldss " + args[:class], data: {id: id, fieldss: fieldss.gsub("\n", "")}) 
	end

	def link_to_add_row_sponsor(name, f, association, **args)
		new_object = f.object.send(association).klass.new 
		id = new_object.object_id 
		fieldsSponsor = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize, f: builder) 
		end
		link_to(name, '#', class: "add_fieldsSponsor " + args[:class], data: {id: id, fieldsSponsor: fieldsSponsor.gsub("\n", "")}) 
	end


	def stripe_standard_path 
		"https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_BOtFLtT9QlPS77k2l7g6xujQg17suDUi&scope=read_write"
	end



end




