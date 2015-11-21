class HomeController < ApplicationController
	def index
		@records = Record.order('updated_at desc').all
	end

	def create
		@url = params[:url]
		if @url.empty?
			FetchDmhyResource.load
		else
			FetchDmhyResource.load @url
		end
	end
end
