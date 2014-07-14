module Concerns
  module UserProfileConcern
    extend ActiveSupport::Concern
    module ClassMethods
      include User
      def build_fb_profile(auth)
        user = SlapUser.new
        user.user_images = [UserImages.new]
        user.via_ouath = true
        user.uid = auth.uid
        user.provider = auth.provider
        user.first_name = auth.info.first_name
        user.last_name = auth.info.last_name
        #user.create_user_user_imageses(auth.info.image)
        #user.user_user_imageses.profile_image = 1
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.user_id = self.check_uid(auth.uid)
        user.avatar = auth.info.image
        user
      end

      def get_user_by_id

      end

    end


  end
end