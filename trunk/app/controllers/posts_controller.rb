class PostsController < ApplicationController
	before_filter :is_administrator

	def new
  		@post = Post.new
  	end

	def create
		@post = current_administrator.posts.build(params[:post])

		respond_to do |format|
			if @post.save
				format.html { redirect_to root_path, notice: 'Post was successfully created.' }
	  			format.json { render json: @post, status: :created, location: @post }
	  			format.js
			else
				format.html { render 'static_pages/home'}
      			format.json { render json: @post.errors, status: :unprocessable_entity }
	            format.js {}
			end
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

    	respond_to do |format|
	    	format.html { redirect_to root_path, success: "Post destroyed" }
	  		format.json { head :no_content }
	  		format.js
  		end
	end

end
