require 'test_helper'

class SlapItemsControllerTest < ActionController::TestCase
  setup do
    @item = slap_items(:valid)
    #@invalid_item =  slap_items(:invalid)
  end

  test "should get index" do
    get :index
  assert_response :success
  assert_not_nil assigns(:items)
  end

  test "Should get slap_item_new" do
     get :new
  assert_response :success
  end
  test "should create new item" do
    assert_difference ('SlapItem.count') do
      post :create,slap_item: {item_title: @item.item_title,item_description: @item.item_description}
      assigns(:notice)
      assert_redirected_to :slap_index
    end
  end
  test "should fail to create a new item" do
    assert_no_difference ('SlapItem.count') do
      post :create,slap_item: {item_title: @item.item_title}
    end
  end
  test "should update a current item" do
       post :update_item, id: @item, slap_item:{item_title: @item.item_title,
                                                item_description: @item.item_description}
       assert_redirected_to :slap_index
  end

end
