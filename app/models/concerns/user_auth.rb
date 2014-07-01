module UserAuth
  extend ActiveSupport::Concern

  module ClassMethods
    include User
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