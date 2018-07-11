class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]
    
    def show
        @user = User.find(params[:id])
        @photos = Photo.all
    end
end
