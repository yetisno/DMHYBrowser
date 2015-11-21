class Category < ActiveRecord::Migration
	def change
		add_column :categories, :sort_id, :string
	end
end
