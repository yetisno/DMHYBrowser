class CreateRecords < ActiveRecord::Migration
	def change
		create_table :records do |t|
			t.string :name
			t.integer :group_id
			t.string :link
			t.string :magnet
			t.string :category_id
			t.boolean :downloaded, default: false

			t.timestamps null: false
		end
	end
end
