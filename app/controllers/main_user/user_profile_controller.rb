class MainUser::UserProfileController  < ApplicationController

  before_action :require_auth, only: [:index]
  def index
    user_id = has_id
  @user = SlapUser.find(user_id)
  @img = @user.user_images.where(:imageable => @user.id,:profile_image => 1).first
  unless @img
    @img = UserImages.new
  end

  end

  def update_profile

  end
  def update_image
    @user = SlapUser.find(has_id)
    @img =  @user.user_images.where(:imageable_id => @user.id,:profile_image => 1) .first
      if @img.update_attributes(update_image_params)
        render :json => {:result => 1, :info => {:img_url => @img.avatar.url(:medium)}}, status: 200
      else
        render :json =>  {:result => 0, :info => "Failure"}, status: 422
      end

  end
  private
  def update_image_params
    params.require(:user_images).permit(:avatar)
  end

end