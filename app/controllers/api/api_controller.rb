module Api
	class ApiController < ApplicationController

		def test
			@users = User.all
			render json: @users
		end

	end
end