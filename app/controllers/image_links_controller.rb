class ImageLinksController < ApplicationController
  def new
    @page_title = "NEW IMAGE"
    @image_link = ImageLink.new
  end

  def show
    @image_link = ImageLink.find(params[:id])
  end

  def index
  end
  
  def create
    image_link = ImageLink.new(params[:image_link])
    
    if image_link.save
      redirect_to :back
      # redirect_to image_link_path(image_link.id)
    else
      redirect_to :back
    end
  end
end

