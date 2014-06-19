class AuthUserController < ApplicationController

  before_action :check_auth, only: [:login,:post_login,:signup,:post_signup]

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
        format.json { render  :login, status: :signout, location: :slap_index }
      end
      else
    redirect_to :slap_index
    end
  end

  def post_login
    @login_user = SlapLogin.new(login_data)
    if @login_user.valid?
      user = SlapLogin.auth_by_email(params[:slap_login][:email],params[:slap_login][:password])
      if user
        set_user_session(user)
        respond_to do |format|
          format.html { redirect_to :slap_index, notice:  t(:successful_login) }
          format.json { render json: "Successful", status: :signed, location: :slap_index }
        end
      else
        flash[:notice] = t(:login_failure)
        respond_to do |format|
          format.html { render  :action =>  :login}
          format.json { render json: t(:login_failure), status: :unprocessable_entity, location: :auth_post_login }
        end

      end
    else
      respond_to do |format|
        format.html{render :action => :login }
        format.json{render json: @login_user.errors,status: :unprocessable_entity }
      end
    end

  end
  # Get /usr/signup
  def signup
    @signup_user = SlapUser.new
  end
  # Post /usr/signup
  def post_signup
    @signup_user = SlapUser.new(signup_data)
    respond_to do |format|
      if  @signup_user.save
        user = SlapUser.order("created_at").last(1)
        user = user.last
        set_user_session(user)
        format.html { redirect_to :slap_index, notice:  'You have been successfully signed up!' }
        format.json { render  :login, status: :created, location: :slap_index }
      else
        format.html{render :action => :signup }
        format.json{render json: @signup_user.errors,status: :unprocessable_entity }
      end
    end

  end

  def signup_data
    params.require(:slap_user).permit(:email,:username,:password,:password_confirmation)
  end

  def login_data
    params.require(:slap_login).permit(:email,:password)
  end





end