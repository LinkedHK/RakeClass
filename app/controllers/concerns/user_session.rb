module Concerns
  module UserSession
          def set_user_session(user,temporary = false)
            session[:user_id] = user[:id]
            if temporary
              session[:tmp_session] = 1
            else
              session[:tmp_session] = 0
            end
          end

          def has_id
            session[:user_id]
          end
    def destroy_user_session
        result = 0
        if has_id
          result  = 1
          session[:user_id] = nil
        end
      result
    end


  end
end

