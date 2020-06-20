class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :update, :destroy]

  # GET /tags
  def index
    @tags = Tag.all

    render json: @tags
  end

  # GET /tags/1
  def show
    render json: @tag.to_json(include: :albums)
  end

  # POST /tags
  def create
    # catch if tag_string already exists (and matches same dbx user id)
    if (Tag.where(tag_string: params[:tag][:tag_string]).where(dbx_user_id: params[:user_id]).count > 0)
      # return that record that is already found
      render json: Tag.where(tag_string: params[:tag][:tag_string]).where(dbx_user_id: params[:user_id]).first
    else 
      #otherwise create a new tag
      @tag = Tag.new(tag_params)

      if @tag.save
        render json: @tag
      else
        render json: @tag.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      render json: @tag
    else
      render json: @tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:tag_string, :dbx_user_id, :tag_type)
    end
end
