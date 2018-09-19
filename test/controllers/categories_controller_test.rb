require "test_helper"

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(firstname: "kat", lastname: "m", username: "katja", email: "bla@gni.lo", email_confirmation: "bla@gni.lo", password: "blabla", password_confirmation: "blabla", admin: true)  
  end
  
  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get categories new" do
    sign_in_as(@user, "blabla")
    get :new
    assert_response :success
  end
  
  test "should get categories show" do
    get(:show, {"id" => @category.id})
    assert_response :success
  end
  
  test "should redirect create when admin not logged in" do
    assert_no_difference "Category.count" do
      post :create, params: { category: { name: "sports" } }
    end
    assert_redirected_to categories_path
  end
end