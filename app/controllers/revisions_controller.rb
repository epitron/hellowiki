class RevisionsController < ApplicationController

  before_filter :load_page

  def index
  end

  def create
    @revision = @page.revisions.new revision_params

    if @revision.save
      redirect_to page_path(@page)
    else
      render :new
    end
  end

  def diff
    @current  = @page.revisions.find params[:id]
    @previous = @current.previous

    @diff = Diffy::Diff.new(@previous.body, @current.body).to_s(:html)
  end


private
  def revision_params
    params.require(:revision).permit(:body, :engine)
  end

  def load_page
    @page = Page.find params[:page_id]
  end

end
