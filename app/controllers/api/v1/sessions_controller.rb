class SessionsController < ApplicationController

    def new
      @user = User.new
      render json :user
    end

    def create
      @user = User.find_by(username: params[:user][:password])
      render json :user, status 201

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        render :new
      end
    end

    def destroy
      session.delete :user_id if session[:user_id]
      redirect_to root_path
      render json :user
      
    end

end