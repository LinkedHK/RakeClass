module  Users

  module UserAuthHelper
    def auth_user(user)
      session[:user_id] = user.id
    end

    def create_user_with_images
     # UserImages.any_instance.stub(:save_attached_files)
      img  =  FactoryGirl.create(:user_images)
      @user = SlapUser.find(img.imageable_id)
      auth_user(@user)
    end

  end

end