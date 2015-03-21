class CharactersController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	helper: characters
	
	def show
		@character = Character.find(params[:id])
	end

	def new
		@character = Character.new
	end

	def create
		@character = Character.new(character_params)
		if @character.save
			render 'success'
		else
			render 'new'
		end
	end

	private

	def character_params
		params.require(:character).permit(:name, :player_class)
	end

end
