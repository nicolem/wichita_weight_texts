require 'test_helper'

class SpanishMessagesControllerTest < ActionController::TestCase
  setup do
    @spanish_message = spanish_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spanish_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spanish_message" do
    assert_difference('SpanishMessage.count') do
      post :create, spanish_message: {  }
    end

    assert_redirected_to spanish_message_path(assigns(:spanish_message))
  end

  test "should show spanish_message" do
    get :show, id: @spanish_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spanish_message
    assert_response :success
  end

  test "should update spanish_message" do
    patch :update, id: @spanish_message, spanish_message: {  }
    assert_redirected_to spanish_message_path(assigns(:spanish_message))
  end

  test "should destroy spanish_message" do
    assert_difference('SpanishMessage.count', -1) do
      delete :destroy, id: @spanish_message
    end

    assert_redirected_to spanish_messages_path
  end
end
