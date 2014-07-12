module  Users

  module UserAuthHelper
    def auth_user(user)
      session[:user_id] = user.id
    end

    def user_with_image
      @user  =  FactoryGirl.create(:user_with_profile_image)
      auth_user(@user)
      @user
    end

  end

end