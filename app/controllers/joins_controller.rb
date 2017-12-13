class JoinsController < ApplicationController
  before_action :authenticate_user!

  def new
    @join = Join.new
    @email = current_user.email 
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