class UsersController < ApplicationController
	skip_before_filter  :verify_authenticity_token

	def new
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		render json: @user
	end

	def create
		@user = User.new(user_params)
		# @user.characters = []
		# @user.bosses = []
		if @user.save
			render 'success'
		else
			render 'new'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end
end
