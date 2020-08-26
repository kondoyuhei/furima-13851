class ApplicationController < ActionController::Base
  # 追加項目を許可する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [
        :nickname, :email, 
        :name_sei, :name_mei, 
        :yomi_sei, :yomi_mei,
        :birthday
       ]
    )
  end

end
