require 'test_helper'

class OptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @option = options(:one)
  end

  test "should get index" do
    get options_url
    assert_response :success
  end

  test "should get new" do
    get new_option_url
    assert_response :success
  end

  test "should create option" do
    assert_difference('Option.count') do
      post options_url, params: { option: { name: @option.name, op10: @option.op10, op11: @option.op11, op12: @option.op12, op13: @option.op13, op14: @option.op14, op15: @option.op15, op16: @option.op16, op17: @option.op17, op18: @option.op18, op19: @option.op19, op1: @option.op1, op20: @option.op20, op21: @option.op21, op22: @option.op22, op23: @option.op23, op24: @option.op24, op25: @option.op25, op2: @option.op2, op3: @option.op3, op4: @option.op4, op5: @option.op5, op6: @option.op6, op7: @option.op7, op8: @option.op8, op9: @option.op9, search_id: @option.search_id, value10: @option.value10, value11: @option.value11, value12: @option.value12, value13: @option.value13, value14: @option.value14, value15: @option.value15, value16: @option.value16, value17: @option.value17, value18: @option.value18, value19: @option.value19, value1: @option.value1, value20: @option.value20, value21: @option.value21, value22: @option.value22, value23: @option.value23, value24: @option.value24, value25: @option.value25, value2: @option.value2, value3: @option.value3, value4: @option.value4, value5: @option.value5, value6: @option.value6, value7: @option.value7, value8: @option.value8, value9: @option.value9 } }
    end

    assert_redirected_to option_url(Option.last)
  end

  test "should show option" do
    get option_url(@option)
    assert_response :success
  end

  test "should get edit" do
    get edit_option_url(@option)
    assert_response :success
  end

  test "should update option" do
    patch option_url(@option), params: { option: { name: @option.name, op10: @option.op10, op11: @option.op11, op12: @option.op12, op13: @option.op13, op14: @option.op14, op15: @option.op15, op16: @option.op16, op17: @option.op17, op18: @option.op18, op19: @option.op19, op1: @option.op1, op20: @option.op20, op21: @option.op21, op22: @option.op22, op23: @option.op23, op24: @option.op24, op25: @option.op25, op2: @option.op2, op3: @option.op3, op4: @option.op4, op5: @option.op5, op6: @option.op6, op7: @option.op7, op8: @option.op8, op9: @option.op9, search_id: @option.search_id, value10: @option.value10, value11: @option.value11, value12: @option.value12, value13: @option.value13, value14: @option.value14, value15: @option.value15, value16: @option.value16, value17: @option.value17, value18: @option.value18, value19: @option.value19, value1: @option.value1, value20: @option.value20, value21: @option.value21, value22: @option.value22, value23: @option.value23, value24: @option.value24, value25: @option.value25, value2: @option.value2, value3: @option.value3, value4: @option.value4, value5: @option.value5, value6: @option.value6, value7: @option.value7, value8: @option.value8, value9: @option.value9 } }
    assert_redirected_to option_url(@option)
  end

  test "should destroy option" do
    assert_difference('Option.count', -1) do
      delete option_url(@option)
    end

    assert_redirected_to options_url
  end
end
