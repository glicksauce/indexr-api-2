class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]

  # GET /albums
  def index
    @albums = Album.all

    render json: @albums.to_json(include: :tags)
  end

  # Get /random_album_id
  # returns a random album
  def random_album_id
    @album = Album.where(dbx_user_id: params[:user_id]).sample
    render json: @album
  end

  # GET /albums/1
  def show
    render json: @album.to_json(include: :tags)
  end

  # POST /albums
  def create
    @album = Album.new(album_params)

    if @album.save
      render json: @album, status: :created, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  def update
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.where(dbx_image_id: params[:dbx_image_id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.require(:album).permit(:dbx_image_id, :image_name, :image_path, :dbx_user_id, :client_modified_date)
    end
end
