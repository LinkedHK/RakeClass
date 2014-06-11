module SlapAuthService


 attr_accessor :validation_errors


 def self.create_account(&session)
          @user = SlapItem.order("created_at").select(:id).last
          session[:user_id] = @user[:id]
 end

  def self.authenticate(userdata)

  end

end