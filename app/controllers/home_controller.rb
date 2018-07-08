class HomeController < ApplicationController
  def index
   @user = User.all
   @photos = Photo.all
   @categories = Category.all
  end
  
  def terms
  end
  
  def search
    @photos    = Photo.ransack(title_cont: params[:q]).result(distinct: true)
    @users = User.ransack(name_cont: params[:q]).result(distinct: true)

     respond_to do |format|
      format.html {}
      format.json {
        @photos    = @photos.limit(5)
        @users = @users.limit(5)
      }
    end
  end
end
