class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      #user is legit, log in
      log_in @user
      if params[:session][:remember_me] == '1'
        remember(@user)
      else
        forget(@user)
      end
      redirect_to @user
    else
      #user was not found. Render new with flash message
      flash.now[:notice] = "Invalid email and password combination"
      render 'new'
    end

  end

  def destroy
    log_out if logged_in?

    flash[:notice] = "You have successfully logged out"
    redirect_to users_path
  end
end
