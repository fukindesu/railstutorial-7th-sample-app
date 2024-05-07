require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    assert_no_difference 'User.count' do
      post users_path,
        params: { user: { name: '', email: 'invalid@email', password: 'foo', password_confirmation: 'bar' } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert.alert-danger'
  end
end
