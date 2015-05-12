class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @user = User.find(params[:user_id])
    @collaborators = User.all
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = User.find(params[:user_id])
    collabs = params[:wiki][:collaborators]
    puts "collabs #{collabs}"
    puts "Wiki params #{wiki_params}"
    @wiki = Wiki.new(wiki_params)
    
    @wiki.user = @user
    authorize @wiki
    if @wiki.save

      collabs.each do |c|
        puts "user id of collab #{c}"
        @wiki.collaborators.create(user_id:c)
      end

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
    params.require(:wiki).permit(:title, :body, :user_id, :private, :collaborators)
  end



end
