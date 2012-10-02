# == Schema Information
#
# Table name: administrators
#
#  id         :integer         not null, primary key
#  kth_id     :string(255)
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Administrator < ActiveRecord::Base
	attr_accessible :kth_id, :name, :email
	has_many :posts, dependent: :destroy

	before_save { |user| user.email = email.downcase }

	validates :kth_id,	presence: true, uniqueness: { case_sensative: false }
	validates :name, 	presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email,	presence: true, format: { with: VALID_EMAIL_REGEX }

end
