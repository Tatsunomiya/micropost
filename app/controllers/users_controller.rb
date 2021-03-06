class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show,:followings, :followers]
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  # def show
  #   @user = User.find(params[:id])
  #   @microposts = @user.microposts.order(id: :desc).page(params[:page])
  #   counts(@user)
  # end
  
    def show
       @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
    end
    
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favorites
      @user = User.find(params[:id])
      @microposts = @user.likes.order(id: :desc).page(params[:page])
      counts(@user)
  end
  
    def favoritesview
      @user = User.find(params[:id])
      @microposts = @user.likes.order(id: :desc).page(params[:page])
      counts(@user)
    end
  
     def likes
    Micropost.where(id: self.fav_mpost_ids )
     end
  
  
  private
  

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  # def likes
  # self.favorites.find_or_create_by(user_id: current_user.id ,micropost_id: microposts.id)
  # end
  

end
