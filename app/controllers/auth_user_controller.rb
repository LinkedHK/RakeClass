class AuthUserController < ApplicationController

  def login
    @login_user = SlapLogin.new
  end

  def post_login
    @login_user = SlapLogin.new(login_data)
    respond_to do |format|
      if  @login_user.valid?
        user = SlapLogin.auth_by_email(@login_user[:email],@login_user[:password])
            if user
              set_user_session(user)
              format.html { redirect_to :slap_index, notice:  'You have been successfully signed in!' }
              format.json { render  :login, status: :created, location: :slap_index }
            else
              format.html{render :action => :signup }
              format.json{render json: @signup_user.errors,status: :unprocessable_entity }
            end
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