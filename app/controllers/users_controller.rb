class UsersController < ApplicationController
	before_action :require_login, :only => [:edit]

	def new
	  @user = User.new
	end

	def create
	  @user = User.new(set_user)
	  if @user.save
	  	auto_login(@user)
	  	NotificationsMailer.registration_confirmation(@user).deliver
	    redirect_to myprofile_edit_path, :alert => "Welcome to StayTraders! Please complete your profile:"
	  else
	    render :new
	  end
	end

	def show 
		@user = current_user
	end

	def edit
		#this will be settings
	end

private

  def set_user
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation, :email) #what should this actually be?                                                       
  end

end
