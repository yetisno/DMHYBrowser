class RecordController < ApplicationController
	def index
		@q = params[:q]
		@limit = @q.empty? ? 100 : 999999
		if (@q.split(' ').length == 1)
			@records = Record.limit(@limit).where('name like ? ', "%#{@q}%").order(:pub_date).reverse_order
		else
			@records = Record.limit(@limit)
			@q.split(' ').each do |qq|
				@records = @records.where('name like ? ', "%#{qq}%")
			end
			@records = @records.order(:pub_date).reverse_order
		end
	end
end
