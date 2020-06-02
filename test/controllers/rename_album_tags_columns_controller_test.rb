require 'test_helper'

class RenameAlbumTagsColumnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rename_album_tags_column = rename_album_tags_columns(:one)
  end

  test "should get index" do
    get rename_album_tags_columns_url, as: :json
    assert_response :success
  end

  test "should create rename_album_tags_column" do
    assert_difference('RenameAlbumTagsColumn.count') do
      post rename_album_tags_columns_url, params: { rename_album_tags_column: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show rename_album_tags_column" do
    get rename_album_tags_column_url(@rename_album_tags_column), as: :json
    assert_response :success
  end

  test "should update rename_album_tags_column" do
    patch rename_album_tags_column_url(@rename_album_tags_column), params: { rename_album_tags_column: {  } }, as: :json
    assert_response 200
  end

  test "should destroy rename_album_tags_column" do
    assert_difference('RenameAlbumTagsColumn.count', -1) do
      delete rename_album_tags_column_url(@rename_album_tags_column), as: :json
    end

    assert_response 204
  end
end
