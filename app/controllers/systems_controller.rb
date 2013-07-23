class SystemsController < ApplicationController
  def index
  end

  def show
    @system = System.find(params[:id])
  end

  def new
    @page_title = "NEW SYSTEM"
    @system = System.new
  end
  
  def create
    system = System.new(params[:system])
    
    if system.save
      redirect_to system_path(system.id)
    else
      render "new"
    end 
  end
end
