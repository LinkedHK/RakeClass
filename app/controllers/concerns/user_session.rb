module Concerns
  module UserSession
       def self.included(base)
        base.helper_method :has_id
       end
          def set_user_session(user,temporary = false)
            session[:user_id] = user[:id]
            if temporary
              session[:tmp_session] = 1
            else
              session[:tmp_session] = 0
            end
          end

          def has_id
             session.has_key?("user_id")
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

