class WikisController < ApplicationController
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
  end

  private
    def wiki_params
      params.require(:wiki).permit(:title, :body)
    end
end
