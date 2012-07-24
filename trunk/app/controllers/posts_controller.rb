class PostsController < ApplicationController
	before_filter :signed_in_administrator, only[:create, :update, :destroy]

	def show
		@posts = Post.paginate(page: params[:page])		
	end

	def create
		@post = current_administrator.posts.build(params[:post])
		if @post.save
			flash[:success] = "Post created!"
			redirect_to root_path
		else
			render 'static_pages/home'
		end
	end

	def update
		
	end

	def destroy
		
	end

end
