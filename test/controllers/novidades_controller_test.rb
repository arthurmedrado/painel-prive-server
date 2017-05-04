require 'test_helper'

class NovidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @novidade = novidades(:one)
  end

  test "should get index" do
    get novidades_url
    assert_response :success
  end

  test "should get new" do
    get new_novidade_url
    assert_response :success
  end

  test "should create novidade" do
    assert_difference('Novidade.count') do
      post novidades_url, params: { novidade: { descricao: @novidade.descricao, titulo: @novidade.titulo } }
    end

    assert_redirected_to novidade_url(Novidade.last)
  end

  test "should show novidade" do
    get novidade_url(@novidade)
    assert_response :success
  end

  test "should get edit" do
    get edit_novidade_url(@novidade)
    assert_response :success
  end

  test "should update novidade" do
    patch novidade_url(@novidade), params: { novidade: { descricao: @novidade.descricao, titulo: @novidade.titulo } }
    assert_redirected_to novidade_url(@novidade)
  end

  test "should destroy novidade" do
    assert_difference('Novidade.count', -1) do
      delete novidade_url(@novidade)
    end

    assert_redirected_to novidades_url
  end
end
