class Lodge < ActiveRecord::Base
	attr_accessible :address, :max_accommodates

	belongs_to :project
	has_many :registrations

	validates :address, 			presence: true
	validates :max_accommodates, 	presence: true, numericality: { only_integer: true }
end
