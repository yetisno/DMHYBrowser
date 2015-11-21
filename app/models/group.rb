class Group < ActiveRecord::Base
	has_many :records
	validates :name, presence: true, uniqueness: true
end
