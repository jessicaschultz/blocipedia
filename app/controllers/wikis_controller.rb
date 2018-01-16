class WikisController < ApplicationController
  # before_action :authorize_user, except: [:show, :new, :create]

  def index
    @wikis = Wiki.all
  end

  def show
    @wikis = Wiki.find(params[:id])
  end

  def new
    @wikis = Wiki.new
  end

  def create
    @wikis = Wiki.new(wiki_params)
    @wikis.user_id = current_user.id
    @wikis.title = params[:wiki][:title]
    @wikis.body = params[:wiki][:body]
    @wikis.save

    if @wikis.save
      flash[:notice] = "You Wiki was published"
      redirect_to [@wikis]
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
    end
  end

  def edit
    @wikis = Wiki.find(params[:id])
  end

  def update
    @wikis = Wiki.find(params[:id])
    @wikis.assign_attributes(wiki_params)

    if @wikis.save
     flash[:notice] = "Wiki was updated."
     redirect_to [@wikis]
    else
     flash.now[:alert] = "There was an error saving the wiki. Please try again."
     render :edit
    end
  end

  def destroy
    @wikis = Wiki.find(params[:id])
    flash.now[:alert] = 'Are you sure you want to delete this wiki?'

    if @wikis.destroy
      flash[:notice] = "\"#{@wikis.title}\" was deleted."
      redirect_to [@wikis]
    else
      flash.now[:alert] = "There was a problem deleting, try again."
      render :show
    end
  end

  private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :id)
    end

    # def authorize_user
    #  @wikis = Wiki.find(params[:id])
    #  unless current_user.id == wikis.user_id
    #    flash[:alert] = "You must be the author of the wiki to do that."
    #    redirect_to [@wikis]
    #  end
    # end
end
