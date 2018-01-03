class JoinsController < ApplicationController

  def new
    @join = Join.new
    @email = current_user.email if current_user.present? && current_user.id
  end

  def create
    @join = Join.new(params[:join])
    @join.request = request
    if @join.deliver
      redirect_to root_path, notice: "Thank you for your application. We will contact you soon!"
    else
      flash.now[:error] = 'Please review the higlighted errors.'
      render :new
    end
  end


end