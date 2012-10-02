class StaticPagesController < ApplicationController
	
	def home
		@project = Project.limit(1).find_by_openRegistration(true)

		@post  = Post.new
		@posts = Post.paginate(page: params[:page])
	end

end
