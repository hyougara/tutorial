class User < ApplicationRecord
    # before_save コールバック処理
    before_save { self.email = email.downcase} # downcaseメソッドを使って小文字にする
    # もう一つのやり方
    #--- before_save { email.downcase! }---
    # presence 存在
    validates :name, presence: true, length: {maximum: 50}
    # 有効なアドレスだけをマッチさせる
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },  # 正規表現 {VALID_EMAIL_REGEX}
                      uniqueness: { case_sensitive: false }#    大文字と小文字を区別する 

     #   データベース内のpassword_digestという属性に保存することができるようになる
    #  password_digestカラムを追加するとpassword属性とpassword_confirmation属性が使えるようになる
    # gem 'bcrypt',   '3.1.12'を追加する
    # そしてhas_secure_passwordが使えるようになる
    has_secure_password
    # 空白と最小文字数を設定する
    validates :password, presence: true, length: { minimum: 6 }
                  
end
