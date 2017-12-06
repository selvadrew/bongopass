class Admin::BaseController < ApplicationController 
	before_filter :ensure_admin_user!

	def ensure_admin_user!
		current_user and current_user.admin?
	end

end