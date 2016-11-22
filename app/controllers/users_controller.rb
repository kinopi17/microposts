class UsersController < ApplicationController
  # 中略

  def new
    @user = User.new(user_params)
    if @user.save
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end