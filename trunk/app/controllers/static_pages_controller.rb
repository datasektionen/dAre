class StaticPagesController < ApplicationController
	
  def home
  	@post = Post.new
  	@posts = Post.paginate(page: params[:page])
  end

  def help
  end

end
