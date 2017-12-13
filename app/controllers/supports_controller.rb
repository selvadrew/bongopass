class SupportsController < ApplicationController

  def new
    @support = Support.new
    @email =  current_user.email if current_user.present? && current_user.id

  end

  def create
    @support = Support.new(params[:support])
    @support.request = request
    if @support.deliver
      redirect_to support_path, notice: "Thank you for your feedback!"
    else
      flash.now[:error] = 'Please review the higlighted errors.'
      render :new
    end
  end


end