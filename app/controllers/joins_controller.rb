class JoinsController < ApplicationController
  before_action :authenticate_user!

  def new
    @join = Join.new
  end

  def create
    @join = Join.new(params[:join])
    @join.request = request
    if @join.deliver
      flash.now[:notice] = 'Thank you for your application. We will contact you soon!'
    else
      flash.now[:error] = 'Cannot send message.'
      render :new
    end
  end


end