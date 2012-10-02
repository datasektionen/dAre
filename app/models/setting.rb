class Setting < ActiveRecord::Base
	attr_accessible :name, :value

	validates :name, 	presence: true, uniqueness: true
	validates :value, 	presence: true
end
