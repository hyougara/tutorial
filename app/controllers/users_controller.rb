class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
   #  @user = User.new(params[:user])[:user]はシンボル
      # @user = User.new(name: "Foo Bar", email: "foo@invalid",
      # password: "foo", password_confirmation: "bar")と同じ事
      # [:user]というシンボルにUser.newで入力したデータを代入している
      
      @user = User.new(user_params) # user_paramsメソッドはUsersコントローラの内部でのみ実行,privateで実行
    if 
      @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      
    else
      render "new"
    end
  end

# privateキーワードでキーワードで外部から不正に使われないようにする
  private 
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end
end
