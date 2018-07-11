class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]


  def download
    require 'open-uri'
    number = @photo_id
    file_name = @photo.image
    url = "https://storage.googleapis.com/ooopic/uploads/photo/image/"+ number + file_name
    data = open(url).read
    send_data data, :disposition => 'attachment', :filename=> @photo_id
    
  end
  
  # Download image from Google Cloud Storage
  def get 
  @photo = Photo.find_by_id(params[:id]) 
    
  if @photo 
    #Parse the URL for special characters first before downloading 
    data = open(URI.parse(URI.encode(@photo.image.url))) 
      
    #then again, use the "send_data" method to send the above binary "data" as file. 
    send_data data.read, :filename => @photo.title, stream: 'true' 
      
    #redirect to amazon S3 url which will let the user download the file automatically 
    #redirect_to photo.uploaded_file.url, :type => photo.uploaded_file_content_type 
  else
    flash[:error] = "Don't be cheeky! Mind your own photos!"
    redirect_to root_url 
  end
  end
  
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = current_user.menu.build
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:title, :image, :admin, :category_id)
    end
end
