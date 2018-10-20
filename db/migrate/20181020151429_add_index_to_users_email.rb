class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  # add_indexメソッドを使いusersテーブルのemailカラムに追加
  def change
    add_index :users, :email, unique: true
  end
end
