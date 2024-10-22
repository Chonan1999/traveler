class ApplicationController < ActionController::Base
    before_action :authenticate_user!,except: [:top] 
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
    def configure_permitted_parameters
      
    end

    def after_sign_in_path_for(resource)
      Posts_path
    end

end
