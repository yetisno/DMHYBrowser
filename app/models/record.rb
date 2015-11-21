class Record < ActiveRecord::Base
	belongs_to :group
	belongs_to :category
	validates :name, presence: true, uniqueness: true
end
