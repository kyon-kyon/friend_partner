class ApplicationController < ActionController::Base
       before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:email,
                   :last_name,
                   :first_name,
                   :kana_last_name,
                   :kana_first_name,
                   :password,
                   :password_confirmation,

                   :introduction,
                   :profile_image_id,
                   :for_what_application,
                   :message_level,
                   :ignore_character,
                   :occupation,
                   :think_to_job,
                   :want_job_time,
                   :think_job_relationship,
                   :can_offer_job,
                   :target_income,
                   :what_want_learn,
                   :like_other_job,
                   :what_desire_love,
                   :how_did_life,
                   :past_failures,
                   :basic_experience,
                   :what_require,
                   :my_personality,
                   :can_offer_personality,
                   :request_relationship_spirit,
                   :interested_by_given
                  ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs

  end

  def name
    last_name + first_name
  end

  def after_sign_in_path_for(resource)
    user_path(resource)
  end




end
