class ApplicationController < ActionController::Base
  before_action :auto_family_login
  before_action :require_family_login
  helper_method :current_family

  private

  def current_family
    @current_family ||= Family.find_by(id: session[:family_id])
  end

  def auto_family_login
    # まだ session に family_id がなければ、cookie から再ログイン
    return if session[:family_id].present?

    if cookies[:family_code]
      family = Family.find_by(code: cookies[:family_code].to_s)
      session[:family_id] = family.id if family
    end
  end

  def require_family_login
    return if session[:family_id].present?

    redirect_to new_family_login_path, alert: "家族コードを入力してください"
  end
end