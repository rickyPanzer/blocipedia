class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  after_action :verify_authorized

  def index
    @public_wikis = Wiki.where(private: false)
    @wikis = Wiki.all
    authorize Wiki
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @user = User.find(params[:user_id])
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = Wiki.new(wiki_params)
    @wiki.user = @user
    authorize @wiki
    if @wiki.save
      flash[:notice] = "Wiki was saved"
      redirect_to @wiki
    else
      flash[:error] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @user = User.find params[:user_id]
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki
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
    authorize @wiki
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
    params.require(:wiki).permit(:title, :body, :user_id, :private)
  end



end
