class RenameAlbumTagsColumnsController < ApplicationController
  before_action :set_rename_album_tags_column, only: [:show, :update, :destroy]

  # GET /rename_album_tags_columns
  def index
    @rename_album_tags_columns = RenameAlbumTagsColumn.all

    render json: @rename_album_tags_columns
  end

  # GET /rename_album_tags_columns/1
  def show
    render json: @rename_album_tags_column
  end

  # POST /rename_album_tags_columns
  def create
    @rename_album_tags_column = RenameAlbumTagsColumn.new(rename_album_tags_column_params)

    if @rename_album_tags_column.save
      render json: @rename_album_tags_column, status: :created, location: @rename_album_tags_column
    else
      render json: @rename_album_tags_column.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rename_album_tags_columns/1
  def update
    if @rename_album_tags_column.update(rename_album_tags_column_params)
      render json: @rename_album_tags_column
    else
      render json: @rename_album_tags_column.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rename_album_tags_columns/1
  def destroy
    @rename_album_tags_column.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rename_album_tags_column
      @rename_album_tags_column = RenameAlbumTagsColumn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rename_album_tags_column_params
      params.fetch(:rename_album_tags_column, {})
    end
end
