class UsersController < ApplicationController
  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @users }
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def sign_out_user
    sign_out(current_user)
    redirect_to root_path, notice: 'Signed out successfully'
  end
end
