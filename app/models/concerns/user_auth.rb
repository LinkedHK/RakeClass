module UserAuth
  extend ActiveSupport::Concern
  module ClassMethods
    def auth_by_email(email,password)
      user = SlapLogin.where(email: email).select(:id,:email,:password).limit(1)
      if user.blank? == false
        user  = user.last
        if user[:password] == Digest::SHA2.hexdigest(password)
          user
        else
          nil
        end
      else
        nil
      end
    end

  end

end