class RelationshipsController < ApplicationController
	before_filter :signed_in_user

	def create
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		respond_to do |format|
			# Note: only one of these is executed based on the availability
			# of create.js.erb.  Note: empirically the html one is not being used...
			# it just bums out and does nothing
			format.html { redirect_to @user }
			format.js
		end
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		respond_to do |format|
			format.html { redirect_to @user }
			format.js
		end
	end
end