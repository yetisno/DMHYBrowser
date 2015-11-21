class RecordAddPubDate < ActiveRecord::Migration
	def change
		add_column :records, :pub_date, :datetime
	end
end
