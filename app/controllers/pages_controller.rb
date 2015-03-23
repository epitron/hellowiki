class PagesController < ApplicationController

  def index
    if query = params[:search]
      @pages = Page.where("LOWER(title) LIKE ?", "%#{query.downcase}%") 
    else
      @pages = Page.all
    end
  end

  def new
    @page     = Page.new
    @revision = Revision.new
  end

  def show
    @page = Page.find params[:id]
  end

  def edit
    @page = Page.find params[:id]
  end

  def create
    @page = Page.new(page_params)
    @page.latest.user_ip = request.ip

    if @page.save
      redirect_to page_path(@page)
    else
      render :new
    end
  end

  def update
    @page = Page.find params[:id]
    @page.assign_attributes(page_params)
    @page.latest.user_ip = request.ip

    if @page.save
      redirect_to page_path(@page)
    else
      render :edit
    end
  end


private
  def page_params
    params.require(:page).permit(:title, revision: [:body, :engine])
  end

end
