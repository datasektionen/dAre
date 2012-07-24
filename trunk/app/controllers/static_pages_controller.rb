class StaticPagesController < ApplicationController
  def home
  	@posts = Post.paginate(page: params[:page])
  end

  def help
  end

end
