# encoding: utf-8
class StaticPagesController < ApplicationController
	include ApplicationHelper

	def home
		@project = get_project

		@post  = Post.new
		@posts = Post.paginate(page: params[:page])
	end

end
