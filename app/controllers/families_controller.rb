class FamiliesController < ApplicationController
  # 家族コード入力画面ではセッションチェックをスキップ
  skip_before_action :require_family_code, only: [:login_form, :login]

  def show
    @family = current_family
  end

  def login_form
    # 家族コード入力フォームを表示するだけ
  end

  def login
    family_code = params[:family_code]

    if Family.exists?(code: family_code)
      session[:family_code] = family_code
      redirect_to root_path, notice: "家族コードでログインしました"
    else
      flash.now[:alert] = "家族コードが間違っています"
      render :login_form
    end
  end

  def logout
    reset_session
    redirect_to family_login_path, notice: "ログアウトしました"
  end
end