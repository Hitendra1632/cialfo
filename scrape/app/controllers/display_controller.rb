class DisplayController < ApplicationController

	
	require 'json'
	require 'open-uri'
	def index
		#reading the file
		@infofile=File.read("public/scrape.json")
		#checking file is empty or not
		if !@infofile.empty?
			@infofile=JSON.parse(@infofile)
		else
			@infofile=[]
		end
		#using gem for pagination
		@infofile=Kaminari.paginate_array(@infofile).page(params[:page]).per(10)
	end	
end
