class Registration < ActiveRecord::Base
	belongs_to :project
	belongs_to :lodge

	before_save :check_values

	validates :kth_id,		presence: true, uniqueness: { case_sensative: false }
	validates :firstname, 	presence: true
	validates :surname, 	presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	presence: true, format: { with: VALID_EMAIL_REGEX }

	validates :mobilephone, presence: true, numericality: { only_integer: true }
	validates :address, 	presence: true
	validates :postalCode, 	presence: true, numericality: { only_integer: true }
	validates :postArea,	presence: true
	validates :grade, 		presence: true

	def check_values

		self.email = self.email.downcase
		self.reserve = false if self.reserve.nil?
		if self.partey.nil?
			self.partey = true
		end
	end
end
