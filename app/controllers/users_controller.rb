class UsersController < ApplicationController
    
    def show
        @user = User.find(params[:id])
        @photos = Photo.all
    end
end
