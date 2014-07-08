module Concerns
  module Http
    module RequestPlugin
      include Concerns::UserSession
      ## Temporary poor solution :)
      LOGIN_FORM = :auth_user_login
      USR_HOME = :slap_index

      def require_auth
        unless has_id
          url = request.original_url
          set_return_session(url)
          redirect_to LOGIN_FORM
        end
      end
      def return_user_url
        return_url = get_return_session
        if return_url
          set_return_session(nil)
          url_for(return_url)
        else
          url_for(USR_HOME)
        end
      end
      def perform_auth_redirect
        return_url = get_return_session
        if return_url
          set_return_session(nil)
          redirect_to return_url
        else
          redirect_to  USR_HOME
        end
      end
      protected
      def get_return_session
        session[:return_url]
      end
      def set_return_session(url)
        session[:return_url] = url

      end

    end
  end

end
