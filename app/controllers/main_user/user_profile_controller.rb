class MainUser::UserProfileController  < ApplicationController

  before_action :require_auth, only: [:index]
  def index
    user_id = has_id
  @user = SlapUser.find(user_id)
   @img = @user.user_images.where(:profile_image => 1).first

  end

  def update_profile

  end

end