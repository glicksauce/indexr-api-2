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
    # takes tag params and puts into array
    formatted_album_tags = params[:album_tags].split(',')

    #get tag_ids, tag_strings and album_ids needed for search. 
    # querying is done with 'IN' searches on the tags, a search for ['long','hair'] will return all id's for both 'long' and 'hair'. the fuction below filters only results that have all tags
    @tag_ids = Tag.where('tag_string ILIKE ANY (array[?])', formatted_album_tags).pluck("id")
    @tag_strings = Tag.where('tag_string ILIKE ANY (array[?])', formatted_album_tags).pluck("tag_string")
    @album_ids = AlbumTag.where(tag_id: @tag_ids).pluck("album_id")

    
    @albums = []
    #for each album_id find out if contains all tag params
    @album_ids.each do | album_id |
      #pull all tag_strings from above query
      @album_result_tags = Album.find(album_id).tags.pluck("tag_string")

      #From inside out:
      #Does a tag param include a queried tag
      #Do the queried tags include all the tag params
      result = @tag_strings.all? {|tag_string| @album_result_tags.any? {|tag| tag_string.include? tag}}
      if (result)
        @albums.push(album_id)
      end
    end



    # OR match try this:
    # @albums = Album.where(dbx_user_id: params[:user_id]).joins(:tags).where('tags.tag_string': ['ultimate','dp','dfdfd'])
    #or
    #@albums = Album.where(dbx_user_id: params[:user_id]).joins(:tags).where('tags.tag_string ILIKE ANY (array[?])', ['jpark','dp'])
    #or    
    # @albums = Album.where(dbx_user_id: params[:user_id]).joins(:tags).where("tags.tag_string @> ARRAY[?]::string", ['17','44'])

    # render json: @albums.to_json(include: :tags)
    render json: Album.find(@albums)
  end

  # GET /albums/1
  def show
    render json: @album.to_json(include: :tags)
  end

  # Get /users/:user_id/albums/directory_search/:directory(.:format) 
  def directory_search
    @albums = Album.where("image_path LIKE ?", params[:directory] + '%')
    @parsedAlbums = []
    
    #count the number of slashes in the directory for searc
    @baseURLSlashCount = params[:directory].count("/")
    @albums.each do |album|
      albumDirectorySlashCount = album.image_path.count("/")
      #if the number of slashes in the album match the number in directory then we know the image is in the same directory
      if albumDirectorySlashCount == @baseURLSlashCount
          @parsedAlbums.push(album)
      end
    end

    #need to count occurance of '/'
    render json: @parsedAlbums
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
