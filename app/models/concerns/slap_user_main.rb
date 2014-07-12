require 'digest/sha1'
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
      def check_uid(uid)
        result = SlapUser.where(:uid => uid).select(:uid,:id).limit(1)
        unless result.blank?
          return result[0]
        end
         result
      end
      def check_email(email)
        result = SlapUser.where(:email => email).select(:email).limit(1)
      end

      def auth_by_email(email,password)
        user = SlapLogin.where(email: email).select(:id,:email,:password).limit(1)
        unless user.blank?
          user  = user.last
          if user[:password] == Digest::SHA2.hexdigest(password)
            return user
          end
        end
        nil
      end
    end
  end
end