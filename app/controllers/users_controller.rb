class UsersController < ApplicationController
  
  def show
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    logged_in_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = "不正なアクセス！"
      redirect_to root_path
    end
  end
  
  def update
    logged_in_user
    @user = User.find(params[:id])
    
    if @user != current_user
      flash[:danger] = "不正なアクセス！"
      redirect_to root_path
    end
    
    if @user.update(user_params)
      # 保存に成功した場合はトップページへリダイレクト
      redirect_to user_path(@user) , notice: 'ユーザー情報を編集しました'
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
   @user = User.find(params[:id])
   @following_users = @user.following_users
  end
  
  def followers
   @user = User.find(params[:id])
   @follower_users = @user.follower_users
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :address)
  end
end
