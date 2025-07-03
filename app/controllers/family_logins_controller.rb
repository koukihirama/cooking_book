class FamilyLoginsController < ApplicationController
  skip_before_action :require_family_login

  def new
    # ログインフォームを表示
  end

  def create
    family = Family.find_by(code: params[:family_code])
    if family
      session[:family_id] = family.id
      cookies.permanent[:family_code] = family.code
      redirect_to root_path, notice: "家族コードを確認しました！"
    else
      flash.now[:alert] = "家族コードが正しくありません"
      render :new
    end
  end

  def destroy
    session.delete(:family_id)
    cookies.delete(:family_code)
    redirect_to new_family_login_path, notice: "ログアウトしました"
  end
end
