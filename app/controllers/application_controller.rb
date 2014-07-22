class ApplicationController < ActionController::Base
  include Concerns::UserSession
  include Concerns::Http::RequestPlugin
  include Concerns::Security::ReqFloodPlugin
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    response = { errors: [error] }
    respond_to do |format|
      format.json { render json: response, status: :unprocessable_entity }
    end
  end
  rescue_from(ActionController::InvalidAuthenticityToken) do |token_missing_exception|
    error = {}
    response = { result: 0, info: 'auth token is missing' }
    respond_to do |format|
      format.json { render json: response, status: :unprocessable_entity }
    end
  end

  helper_method :has_id



end
