module  Users

  module UserAuthHelper
    def auth_user
      session[:user_id] = 123
    end

  end

end