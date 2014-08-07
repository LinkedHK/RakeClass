class MainUser::UserProfileController  < ApplicationController

  before_action :require_auth, only: [:index]
  def index
    @user = SlapProfile.get_uprofile(has_id)
    @img = @user.avatar
  end

  def update_profile
    @user = SlapProfile.update_profile(has_id,update_profile_params)
    respond_to do |format|
      if @user
        format.html{}
        format.json{render :json =>{:result => 1, :info => t(:profile_update_successful)}, status: 200  }
      else
        format.html{}
        format.json{render :json =>{:result => 0, :info => @user.errors}, status: 422  }
      end
    end
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

  def update_profile_params
    params.require(:slap_user).permit(:first_name,:last_name)
  end


end