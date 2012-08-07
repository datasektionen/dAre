class Registration < ActiveRecord::Base
	belongs_to :project
	belongs_to :lodge
end
