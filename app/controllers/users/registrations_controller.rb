class Users::RegistrationsController < Devise::RegistrationsController
  def new
    build_resource
    resource.build_family
    respond_with resource
  end

  def create
    build_resource(sign_up_params)
    resource.build_family(family_params)

    if resource.save
      sign_up(resource_name, resource)
      redirect_to root_path, notice: "アカウント登録が完了しました"
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def family_params
    params.require(:user).require(:family_attributes).permit(:name)
  end
end
