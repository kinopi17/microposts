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
      flash[:success] = "Welcome to the sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user=User.find(params[:id])
    if @user!=current_user
      redirect_to root_url
    end
  end
  
  def update
    @user=User.find(params[:id])
    if @user!=current_user
      redirect_to root_url
    end
   respond_to do |format|
     if @user.update(user_params)
       format.html { redirect_to @user,notice:'profile was successfully updated.'}
       format.json {head:no_content}
     else
       format.html{render action:'edit'}   
       format.json{render json: @user.errors,status: :unprocessable_entity}
     end
   end
  end  
  def followings
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :area, :profile, :password,
                                 :password_confirmation)
  end
end
