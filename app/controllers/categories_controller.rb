class CategoriesController < ApplicationController
	before_action :require_user, only: [:new, :create] 	# defined in application_controller.rb
	before_action :require_admin, only: [:new, :create]	# defined in application_controller.rb

	def show
		@category = Category.find_by(slug: params[:id])
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params.require(:category).permit(:name))

		if @category.save
			flash[:notice] = "You created a new category"
			redirect_to posts_path
		else
			render :new
		end
	end

end
