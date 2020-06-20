class AlbumTagsController < ApplicationController
  before_action :set_album_tag, only: [:update, :destroy]

  # GET /album_tags
  def index
    @album_tags = AlbumTag.all

    # render json: @album_tags.to_json(include: [:album, :tag])
    render json: @album_tags.to_json(include: :tag)
  end
  
  #GET /user_album_tags
  # show all tags per given dbx_user_id
  def user_album_tags
    @album_tags = Tag.where(dbx_user_id: params[:user_id]).joins(:album_tags).group(:tag_string).order('COUNT(tag_string) DESC').count
    render json: @album_tags
  end

  # GET /album_tags/1
  def show
    render json: @album_tag
  end

  # POST /album_tags
  def create
    @album_id = Album.where(dbx_image_id: params[:album_dbx_image_id]).pluck("id")
    @album_tag = AlbumTag.new(tag_id: album_tag_params[:tag_id], album_id: @album_id[0])
  
    # render json: params
    # render json: album_tag_params[:tag_id]

    if @album_tag.save
      render json: @album_tag, status: :created, location: @album_tag
    else
      render json: @album_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /album_tags/1
  def update
    if @album_tag.update(album_tag_params)
      render json: @album_tag
    else
      render json: @album_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /destroy_album_tags
  # takes the dbx image id finds the related album_tags then destroys all of them
  def destroy_album_tags

    @album_id = Album.where(dbx_image_id: params[:album_dbx_image_id]).pluck("id")
    AlbumTag.where(album_id: @album_id[0]).destroy_all
    render json: params
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album_tag
      @album_tag = AlbumTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_tag_params
      params.require(:album_tag).permit(:album_id, :tag_id, :dbx_image_id)
    end
end
