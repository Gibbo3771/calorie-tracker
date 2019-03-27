module Sinatra 
    module Nom
        module SessionHelper

            def require_active_profile()
                redirect('/') unless profile_active?()
            end

            def activate_profile(profile)
                return if profile.nil?
                session[:profile_id] = profile.id
            end

            def profile_active?()
                return !!session[:profile_id]
            end

            def profile_exists?(profile)
                return !!profile
            end

            def deactivate_profile()
                session[:profile_id] = nil
            end
        end
    end

end