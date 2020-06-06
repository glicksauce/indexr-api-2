require 'test_helper'

class DropAndCreateNewAlbumTagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @drop_and_create_new_album_tag = drop_and_create_new_album_tags(:one)
  end

  test "should get index" do
    get drop_and_create_new_album_tags_url, as: :json
    assert_response :success
  end

  test "should create drop_and_create_new_album_tag" do
    assert_difference('DropAndCreateNewAlbumTag.count') do
      post drop_and_create_new_album_tags_url, params: { drop_and_create_new_album_tag: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show drop_and_create_new_album_tag" do
    get drop_and_create_new_album_tag_url(@drop_and_create_new_album_tag), as: :json
    assert_response :success
  end

  test "should update drop_and_create_new_album_tag" do
    patch drop_and_create_new_album_tag_url(@drop_and_create_new_album_tag), params: { drop_and_create_new_album_tag: {  } }, as: :json
    assert_response 200
  end

  test "should destroy drop_and_create_new_album_tag" do
    assert_difference('DropAndCreateNewAlbumTag.count', -1) do
      delete drop_and_create_new_album_tag_url(@drop_and_create_new_album_tag), as: :json
    end

    assert_response 204
  end
end
