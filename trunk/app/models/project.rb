class Project < ActiveRecord::Base
	has_many :registrations

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	presence: true, format: { with: VALID_EMAIL_REGEX }

	validates :year,	presence: true, uniqueness: { case_sensative: false }
						numericality: { only_integer: true }
end
