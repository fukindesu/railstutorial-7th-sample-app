require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user =
      User.new(name: 'Example User', email: 'user@example.com', password: 'password', password_confirmation: 'password')
    @valid_emails =
      ['user@example.com', 'USER@foo.COM', 'A_US-ER@foo.bar.org', 'first.last@foo.jp', 'alice+bob@baz.cn']
    @invalid_emails =
      ['user@example,com', 'user_at_foo.org', 'user.name@example.', 'foo@bar_baz.com', 'foo@bar+baz.com', 'foo@bar..com']
  end

  test 'shoud be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name shoud not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid emails' do
    @valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?, "#{valid_email.inspect} shoud be valid"
    end
  end

  test 'email validation should reject invalid emails' do
    @invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} shoud be invalid"
    end
  end

  test 'emails should be unique' do
    duplicated_user = @user.dup
    @user.save
    assert_not duplicated_user.valid?
  end

  test 'emails should be saved as lowercase' do
    @user.email = 'MixedCaseEmail@ExaMple.coM'
    @user.save
    assert_equal @user.email.downcase, @user.reload.email
  end

  test 'password should be present (nonblank)' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test 'associated microposts should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'Lorem ipsum')
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end
end
