class WikisController < ApplicationController
  before_action :require_sign_in, except: [:show]

  def index
    @wikis = Wiki.all
  end

  def show
    # @user = authorize User.find(params[:id])
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    # @wiki.save

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
    # @wiki_user = @wikis.user_id
    # authorize Wiki
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
    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore
      flash[:warning] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
      redirect_to(request.referrer || root_path)
    end

    def wiki_params
      params.require(:wiki).permit(:title, :body, :id)
    end

    def authorize_user
     @wiki = Wiki.find(params[:id])
     unless current_user == @wiki.user
       flash[:alert] = "You must be the author of the wiki to do that."
       redirect_to [@wikis]
     end
    end
end
