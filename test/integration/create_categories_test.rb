require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = User.create(firstname: "kat", lastname: "m", username: "katja", email: "bla@gni.lo", email_confirmation: "bla@gni.lo", password: "blabla", password_confirmation: "blabla", admin: true)
  end
  
  test "get new category form and create new category" do
    sign_in_as(@user, "blabla")
    get new_category_path
    assert_template "categories/new"
    assert_difference "Category.count", 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template "categories/index"
    assert_match "sports", response.body
  end
  
  test "invalid category submision results in failure" do
    sign_in_as(@user, "blabla")
    get new_category_path
    assert_template "categories/new"
    assert_no_difference "Category.count" do
      post categories_path, category: { name: " " }
    end
    assert_template "categories/new"
    assert_select "div.category-form"
  end
end