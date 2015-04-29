class WikisController < ApplicationController
  
  after_action :verify_authorized

  def index
    @wikis = Wiki.all
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    if @wiki.update(wiki_params)
      flash[:notice] = "Wiki updated"
      redirect_to @wiki
    else
      flash[:error] = 'There was an error saving the wiki. Please try again'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "Wiki successfully deleted"
      redirect_to wikis_path
    else
      flash[:error] = "There was an error. Please try again"
      render :show
    end
  end

private

  def wiki_params
    params.require(:wiki).permit(:title, :body)
  end



end
