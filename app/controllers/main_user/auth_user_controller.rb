class MainUser::AuthUserController < ApplicationController
  before_action :check_auth, only: [:login,:post_login,:signup,:post_signup,:social_create]
 #before_action :resolve_fb_user, only: [:login]
  def check_auth
    if has_id
      redirect_to :slap_index
    end
  end
  def login
    @login_user = SlapLogin.new
  end

  def logout
    if destroy_user_session
      respond_to do |format|
        format.html { redirect_to :slap_index, notice:  t(:successful_signout) }
        format.json { render  json: { :result => 1,:info => t(:successful_signout) } }
      end
      else
    redirect_to :slap_index
    end
  end

  def post_login
    @login_user = SlapLogin.new(login_data)
      respond_to do |format|
      if @login_user.valid?
        user = SlapUser.auth_by_email(params[:slap_login][:email],params[:slap_login][:password])
        if user
          set_user_session(user)
            format.html { redirect_to :slap_index, notice:  t(:successful_login) }
            format.json { render json: {:result => 1, :info => t(:successful_login)},status: 200 }
        end
      end
      format.html{render :action => :login }
      format.json{render json: {:result => 0, :info => t(:login_failure)},status: 422,:action => :login }
      end
  end
  # Get /usr/signup
  def signup
    @signup_user = SlapUser.new
  end
  # Post /usr/signup
  def post_signup
    @signup_user = SlapUser.new(signup_data)
    @signup_user.user_images = [UserImages.new(:profile_image => 1)]
    respond_to do |format|
      if  @signup_user.save
        set_user_session({:id => @signup_user.id})
        format.html { redirect_to :slap_index, notice:  t(:successful_signup) }
        format.json { render  json: { :result => 1,:info => t(:successful_signup) } ,status: 200}
      else
        format.html{render :action => :signup }
        format.json{render json: {:result => 0, :info => @signup_user.errors}, status: 422 }
      end
    end
  end

  def result_sign

  end
  def facebook_login
    @red = url_for(return_user_url)
    @error = false
    auth =request.env['omniauth.auth']
    @user = SlapUser.build_profile_omniauth(auth)
    user_id = SlapUser.check_uid(@user.uid)
      if user_id.blank?
        if @user.save
         img = UserImages.avatar_from_url(@user,auth.info.image)
         if img.save
           set_user_session({:id => @user.id})
         end
        else
          @error = true
          return render :social_create
        end
      else
        #  else User with specified uid exists
        set_user_session(user_id)
      end
     render :social_create
  end

  def social_failure
    message_key = env['omniauth.error.type']
    new_path = "#{env['SCRIPT_NAME']}#{OmniAuth.config.path_prefix}/failure?message=#{message_key}"
    Rack::Response.new(["302 Moved"], 302, 'Location' => new_path).finish
  end

  def signup_destroy
    params.require(:slap_user).permit(:email,:username,:password,:password_confirmation)
  end

  def login_data
    params.require(:slap_login).permit(:email,:password)
  end

  def signup_data
    params.require(:slap_user).permit(:email,:username,:password,:password_confirmation)
  end
end