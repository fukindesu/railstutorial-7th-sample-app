require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    get contact_path
    assert_select 'title', full_title('Contact')
    get signup_path
    assert_select 'title', full_title('Sign up')
  end

  test "login/logout links when not logged in" do
    get root_path
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', logout_path, count: 0
  end

  test 'login/logout links when logged in' do
    log_in_as(@user)
    get root_path
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', logout_path
  end
end
