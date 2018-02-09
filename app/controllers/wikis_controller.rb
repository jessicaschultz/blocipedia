class WikisController < ApplicationController
  before_action :require_sign_in, except: [:show]

  def index
    @wikis = policy_scope(Wiki)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    unless @wiki.private == false || @wiki.user == current_user|| current_user.admin? || current_user.role == "premium"
      flash[:alert]= "Sorry, but you need to be a premium member in order to access this post."
      redirect_to wikis_path
    end
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was published"
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
     flash[:notice] = "Wiki was updated."
     redirect_to @wiki
    else
     flash.now[:alert] = "There was an error saving the wiki. Please try again."
     render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    flash.now[:alert] = 'Are you sure you want to delete this wiki?'

    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was a problem deleting, try again."
      render :show
    end
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def wiki_params
      params.require(:wiki).permit(:title, :body, :id, :private)
    end

    def authorize_user
     @wiki = Wiki.find(params[:id])
     unless current_user == @wiki.user
       flash[:alert] = "You must be the author of the wiki to do that."
       redirect_to [@wikis]
     end
    end
end
