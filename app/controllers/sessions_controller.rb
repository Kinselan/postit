class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.where(username: params[:username]).first
		# where returns an array, even if there is only one item

		if user && user.authenticate(params[:password])
			session[:user_id] = user.id # save ID only because cookie has size limitations
			flash[:notice] = "Welcome, you've logged in."
			redirect_to root_path

		else
			flash.now[:error] = "Username or Password incorrect."
			render :new
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've logged out."
		redirect_to root_path
	end
end
