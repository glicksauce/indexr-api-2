class AlbumTagsController < ApplicationController
  before_action :set_album_tag, only: [:show, :update, :destroy]

  # GET /album_tags
  def index
    @album_tags = AlbumTag.all

    render json: @album_tags.to_json(include: [:album, :tag])
  end

  # GET /album_tags/1
  def show
    render json: @album_tag
  end

  # POST /album_tags
  def create
    @album_tag = AlbumTag.new(album_tag_params)

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

  # DELETE /album_tags/1
  def destroy
    @album_tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album_tag
      @album_tag = AlbumTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def album_tag_params
      params.require(:album_tag).permit(:image_id, :tag_id)
    end
end
