require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # setupというメソッドで有効なオブジェクトを作成し全てのテストで@userと言うインスタンス変数を使えるようにする
  # validというメソッドで有効性を確認できるようになる

  def setup
    @user = User.new(name:"Example User", email:"user@example.com",
    #  foobarは変数,password_digestカラムを追加するとpassword属性とpassword_confirmation属性が使えるようになる
            password:"foobar", password_confirmation:"foobar")
  end
  # valid 有効
# assert 断言
  test "should be valid" do
    assert @user.valid?
  end
  # should be ~のはず present 今,現在
# nameの存在確認
  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end
# emailの存在確認
  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  # これでemailが正しいか確認
  # inspect 調査
  test "email validation should accept valid addresses" do
    valid_addresses = %w[usr@example.com USER@foo.com A_US-ER@foo.bar.org
                          first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be vaild"
    end
  end
  # duplicate 二重、重複 # 一意性を確認
  #@userと同じアドレスを使えないことを@user.dupを使ってテストしている,dupは同じ属性の複製するメソッド
  test "email addresses should be unique" do
    duplicate_user = @user.dup  
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?

  end
# 大文字小文字がmixの場合のテスト
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
