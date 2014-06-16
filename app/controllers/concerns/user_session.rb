module Concerns
  module UserSession
       extend ActiveSupport::Concern
          def set_user_session(user)
            session[:user_id] = user[:id]
          end
  end
end

