module Concerns
  module SlapUserMain

    extend ActiveSupport::Concern
      def encrypt_password
        self.password = Digest::SHA2.hexdigest(self.password)
      end

      def get_saved_user
        saved_user = SlapUser.order("created_at").last(1)
      end
    module ClassMethods
      include User
      def from_omniauth(auth)
        where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
          user.via_ouath = true
          user.uid = auth.uid
          user.provider = auth.provider
          user.first_name = auth.info.first_name
          user.last_name = auth.info.last_name
          user.email = auth.info.email
          user.oauth_token = auth.credentials.token
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          return user
        end
      end
      def check_uid(uid)
        result = SlapUser.where(:uid => uid).select(:uid,:id).limit(1)
      end
      def check_email(email)
        result = SlapUser.where(:email => email).select(:email).limit(1)
      end
    end
  end
end