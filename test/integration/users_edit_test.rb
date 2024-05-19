require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = ''
    email = 'invalid@email'
    password = 'foo'
    password_confirmation = 'bar'
    patch user_path(@user), params: { user: { name:, email:, password:, password_confirmation: } }
    assert_template 'users/edit'
    assert_select 'div.alert', text: 'The form contains 4 errors.'
  end

  test 'successful edit with friendly formawding' do
    get edit_user_path(@user)
    assert_equal edit_user_url(@user), session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name = 'Foo Bar'
    email = 'valid@example.com'
    password = ''
    password_confirmation = ''
    patch user_path(@user), params: { user: { name:, email:, password:, password_confirmation: } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
    assert_nil session[:forwarding_url]
  end
end
