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

  # Get /users/:user_id/albums/:album_tags/tags_search
  # returns albums that match tags provided (AND search)
  def tags_search
    # @albums = Album.where(dbx_user_id: params[:user_id]).joins(:tags).where('tags.tag_string' => params[:album_tags])
    formatted_album_tags = params[:album_tags].split(',')
    @tag_ids = Tag.where('tag_string ILIKE ANY (array[?])', formatted_album_tags).pluck("id")
    @tag_strings = Tag.where('tag_string ILIKE ANY (array[?])', formatted_album_tags).pluck("tag_string")
    @album_tag_ids = AlbumTag.where(tag_id: @tag_ids)
    @album_ids = AlbumTag.where(tag_id: @tag_ids).pluck("album_id")
    @albums = []
    @album_ids.each do | album_id |
      @album_result_tags = Album.find(album_id).tags.pluck("tag_string")
      result = @album_result_tags.all? { |tag| @tag_strings.include? tag}
      if (result)
        @albums.push(album_id)
      end
    end
    # @albums = Album.where(dbx_user_id: params[:user_id]).joins(:tags).where("tags.tag_string @> ARRAY[?]::string", ['17','44'])


    # OR match try this:
    # @albums = Album.where(dbx_user_id: params[:user_id]).joins(:tags).where('tags.tag_string': ['ultimate','dp','dfdfd'])
    #or
    #@albums = Album.where(dbx_user_id: params[:user_id]).joins(:tags).where('tags.tag_string ILIKE ANY (array[?])', ['jpark','dp'])
    # render json: @albums.to_json(include: :tags)
    render json: @albums
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
