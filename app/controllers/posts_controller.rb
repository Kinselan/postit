class PostsController < ApplicationController

	before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index]
	before_action :require_creator, only: [:edit, :update]
	# before_action :require_admin, only: [:edit, :update]	# defined in application_controller.rb

  def index
  	@posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
  	@post = Post.new
  end

  def create

  	# Post.create(title: params[:my_title]).  # we could do this with HTML forms
  	@post = Post.new(post_params) # post_params is defined in private below

  	@post.creator = current_user # current user must excist because of before_action :require_user

  	if @post.save
  		flash[:notice] = "Your post was created."
  		redirect_to posts_path
  	else
  		render :new # or 'new'
  	end

  	# Post.create(params[:post]) # because we used rails model-backed form helpers
  end

  def edit
  end

  def update
  	if @post.update(post_params)
  		flash[:notice] = "Your post was updated."
  		redirect_to posts_path # or post_path(@post)
  	else
  		render :edit # or 'edit'
  	end
  end

	def vote
		# @vote needs to be an instance variable so it flows to templates
		@vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

		respond_to do |format|
			format.html do
				if @vote.valid?
					flash[:notice] = 'Your vote was counted!'
				else
					flash[:error] = 'You can only vote once.'
				end
				redirect_to :back
			end
			format.js # if left blank, will render post/vote.js.erb
		end
	end

  private

  def post_params # this handles strong parameters
  	# if user.admin?
  		params.require(:post).permit! # exposes fields for mass-assignment

      # below includes way to set arrays (category ids):
      # params.require(:post).permit(:title, :url, :description, category_ids: [])
  	# else
  		# params.require(:post).permit(:title, :url)
  	# end
  end

  def set_post
		@post = Post.find_by(slug: params[:id])
  end

	def require_creator
		access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
	end
end
