class PostsController < ApplicationController
	before_filter :signed_in_administrator

	def new
  		@post = Post.new
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

	def edit
    	@post = Post.find(params[:id])
    end

	def update
		@post = Post.find(params[:id])

    	if @post.update_attributes(params[:post])
    		flash[:success] = "Post updated";
    		redirect_to root_path
    	else
    		render 'edit'      
    	end
	end

	def destroy
		Post.find(params[:id]).destroy
   		flash[:success] = "Post destroyed"
    	redirect_to root_path
	end

end
