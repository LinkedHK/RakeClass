module AuthUserHelper

  def get_last_joined_users(limit = 10,offset = 0)
    (limit > 20 || limit < 1 )  ?  limit = 10 : limit
   @user =  SlapUser.order("created_at").limit(limit).offset(offset) .select(:id, :username,:created_at)
  end

end
