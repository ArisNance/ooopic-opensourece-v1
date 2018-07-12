class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]


  
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
    @tags = Tag.all
    @photos = Photo.all
    @categories = Category.all
  if params[:tag]
    @photos = Photo.tagged_with(params[:tag])
  else
    @photos = Photo.all.order("created_at DESC")
  end
  end
  
  def search
    if params[:search].nil?
      @photos = []
    else
      @photos = Photo.search params[:title]
    end
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new ## categories are not working on new method. Only works with Update.
  if current_user
    @photo = current_user.photos.build
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  else
    redirect_to root_url notice: 'You must sign in or sign up first.'
  end
    
  end

  # GET /photos/1/edit
  def edit
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = current_user.photos.build(photo_params)
    @photo.category_id = params[:category_id]

    respond_to do |format|
      if @photo.save
        format.html { redirect_to profile_path(current_user), notice: 'Photo was successfully created.' }
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
    @photo.category_id = params[:category_id]
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to profile_path(current_user), notice: 'Photo was successfully updated.' }
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
      params.require(:photo).permit(:title, :image, :admin, :category_id, :tag_list, :tag, { tag_ids: [] }, :tag_ids)
    end
end
