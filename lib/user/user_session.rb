module User
  class UserSession
    def initialize(session)
      @session = session
    end

    def set_user(user)
      @session[:user_id] = user[:id]
    end
  end
end