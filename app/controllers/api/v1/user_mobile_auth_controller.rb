class Api::V1::UserMobileAuthController < ApplicationController
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/vnd.slap.v1' }



   def mobile_login

     valid = true
     if user = SlapMobileLogin.find_user_by_email(params[:email])
       unless user.compare_passwords(params[:password])
         valid = false
       end
     else
       valid = false
     end

     if valid
       render :json => { :result => 1,:info => user.build_response }, :status => 200
     else
       render :json => { :result => 0,:info => "Invalid login"}, :status => 200
     end

   end

  # Post /usr/rest/v1/login
  def post_login
    @login_user = SlapLogin.new(login_data)
    if @login_user.valid?
      user = SlapUser.auth_by_email(@login_user.email,@login_user.password)
      if user
        set_user_session(user)
        return render :json => { :result => 1, :info => t(:successful_login), :session_id => cookies['sessionsid'], :status => 200}
      else
     return render :json => { :result => 0, :info => t(:login_failure) }, :status => :unprocessable_entity
      end
    end
    render :json => { :result => 0, :info => @login_user.errors }, :status => :unprocessable_entity
  end
  # Post /usr/rest/v1/logout
  def logout
    destroy_user_session
    render :json => { :result => 1,:info => t(:successful_signout) }, :status => 200
  end
  # Post /usr/rest/v1/signup
  def post_signup
    @signup_user = SlapUser.new(signup_data)
      if  @signup_user.save
        user = SlapUser.order("created_at").last(1)
        user = user.last
        set_user_session(user)
        render :json => { :result => 1,:info => t(:successful_signup) }, :status => 200
      else
        render :json => { :result => 0,:info =>  @signup_user.errors, }, :status => 422
      end
  end
  def mobile_login_data
    params.permit(:email,:password,:inst_id)
  end
  def login_data
    params.require(:slap_login).permit(:email,:password)
  end
  def signup_data
    params.require(:slap_user).permit(:email,:username,:password,:password_confirmation)
  end


end