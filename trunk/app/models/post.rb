class Post < ActiveRecord::Base
	attr_accessible :headline, :content
	belongs_to :administrator

	validates :headline, presence: true, length: { maximum: 40 }
	validates :content, presence: true
	validates :administrator_id, presence: true

	default_scope order: 'posts.created_at DESC'
end
