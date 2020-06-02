require 'test_helper'

class AlbumTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @album_tag = album_tags(:one)
  end

  test "should get index" do
    get album_tags_url, as: :json
    assert_response :success
  end

  test "should create album_tag" do
    assert_difference('AlbumTag.count') do
      post album_tags_url, params: { album_tag: { image_id: @album_tag.image_id, tag_id: @album_tag.tag_id } }, as: :json
    end

    assert_response 201
  end

  test "should show album_tag" do
    get album_tag_url(@album_tag), as: :json
    assert_response :success
  end

  test "should update album_tag" do
    patch album_tag_url(@album_tag), params: { album_tag: { image_id: @album_tag.image_id, tag_id: @album_tag.tag_id } }, as: :json
    assert_response 200
  end

  test "should destroy album_tag" do
    assert_difference('AlbumTag.count', -1) do
      delete album_tag_url(@album_tag), as: :json
    end

    assert_response 204
  end
end
