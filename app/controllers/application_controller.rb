class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, raise: false
  skip_after_action :verify_authorized
    rescue_from CanCan::AccessDenied do
        flash[:error] = 'Access denied!'
        redirect_to root_url
      end 
  # around_filter :query_cache_secondBase
  # private
  # def query_cache_secondBase
  #   SecondBase::Base.connection.cache { yield }
  # end
end