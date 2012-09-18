class Staff < ActiveRecord::Base
	attr_accessible :name, :mobilephone, :email

	has_and_belongs_to_many :projects

	before_save { |staff| staff.email = email.downcase }

	validates :name, 			presence: true
	validates :mobilephone, 	presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i		
	validates :email,	presence: true, format: { with: VALID_EMAIL_REGEX }
end
