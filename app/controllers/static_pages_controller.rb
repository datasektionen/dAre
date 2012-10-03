class StaticPagesController < ApplicationController
	
	def home
		@project = Project.last

		@post  = Post.new
		@posts = Post.paginate(page: params[:page])
	end

end
