class AuthUserController < ApplicationController
  def login

  end

  def post_login
  end
  # Get /usr/signup
  def signup
    @sign_user = SlapUser.new
  end
  # Post /usr/signup
  def post_signup

    @sign_user = SlapUser.new(sign_data)

    respond_to do |format|
      if @sign_user.save
      #SlapAuthService.create_account(session)

        format.html { redirect_to :slap_index, notice:  'Status was successfully created.' }
        format.json { render  :login, status: :created, location: :slap_index }
      else
        format.html{render :action => :signup }
        format.json{render json: @sign_user.errors,status: :unprocessable_entity }
      end
    end

  end

  def sign_data
    params.require(:slap_user).permit(:email,:username,:password,:password_confirmation)
  end


end