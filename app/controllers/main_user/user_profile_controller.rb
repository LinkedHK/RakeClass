class MainUser::UserProfileController  < ApplicationController

  before_action :require_auth, only: [:index]
  def index
    @user = SlapProfile.get_user_profile(has_id)
    @img = @user.get_profile_image
  end
  def update_image
    @img = SlapProfile.update_profile_image(has_id,update_image_params)
      if @img
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