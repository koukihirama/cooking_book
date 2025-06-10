class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def create
    # データベースのトランザクションを開始,全ての処理が成功した場合のみデータが保存される
    ActiveRecord::Base.transaction do
      # Family を作成
      family = Family.create!(name: sign_up_params[:family_name])

      # User を作成して Family に紐づけ
      # build_resourceは新しいユーザーオブジェクトを構築する。
      # sign_up_params.except(:family_name)は、ユーザーオブジェクトには家族名が含まれないようにユーザーの登録時に送信されたパラメータからfamily_nameを除外している。
      build_resource(sign_up_params.except(:family_name))
      # resourceは、build_resourceで作成されたユーザーオブジェクトを指している
      # ここで、作成したFamilyオブジェクト（family）をユーザーオブジェクトのfamily属性に設定してユーザーとその家族を関連付けている
      resource.family = family
      # 保存に失敗した場合はActiveRecord::RecordInvalid例外が発生する
      # これにより、ユーザーとその家族の情報が同時にデータベースに保存される
      resource.save!

      # ブロックが渡されている場合、resourceをブロックに渡す。これにより、外部からの追加処理が可能になる
      yield resource if block_given?
      # resourceがデータベースに保存されているか（永続化されているか）をチェックする
      if resource.persisted?
        # resourceが認証のためにアクティブかどうかを確認する。アクティブであれば、ユーザーはログイン可能
        if resource.active_for_authentication?
          # サインアップ成功のメッセージをフラッシュメッセージとして設定する。これにより、次のページでメッセージが表示される
          set_flash_message! :notice, :signed_up
          # ユーザーをサインアップさせる処理を行う。これでユーザーが正式に登録される
          sign_up(resource_name, resource)
          # resource（ユーザーオブジェクト）に基づいて、適切なレスポンスを返す。サインアップ後のリダイレクト先はafter_sign_up_path_for(resource)で指定される
          respond_with resource, location: after_sign_up_path_for(resource)

          # ユーザーがアクティブでない場合の処理
        else
          # サインアップは成功したが、ユーザーがアクティブでないことを知らせるメッセージを設定する
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          # サインイン後のデータをクリアする処理。これにより、セッションのデータをリセットする
          expire_data_after_sign_in!
          # ユーザーをアクティブにするための処理を行った後、適切なレスポンスを返す。リダイレクト先はafter_inactive_sign_up_path_for(resource)で決まる
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end

      # resourceがデータベースに保存されていない場合の処理
      else
        # リソースのパスワードをクリーンアップする処理。これにより、セキュリティが向上する
        clean_up_passwords resource
        # パスワードの最小長を設定する。これにより、ユーザーにパスワードの要件を伝えることができる
        set_minimum_password_length
        # resourceに基づいてレスポンスを返す。エラーがあった場合のデフォルトの応答
        respond_with resource
      end
    end
  # ActiveRecord::RecordInvalid例外が発生した場合に、そのエラーを捕捉する処理を開始
  rescue ActiveRecord::RecordInvalid
    # フラッシュメッセージのalertにエラーメッセージを設定する。flash.nowを使うことで、次のリクエストではなく、現在のリクエストでのみ表示される
    flash.now[:alert] = "家族名の作成に失敗しました。"
    # :newアクションのビューを再表示する。これにより、ユーザーは再度フォームを入力できるようになる
    render :new
  end

  protected

  def configure_permitted_parameters
    # devise_parameter_sanitizerを使って、サインアップ時に許可するパラメーターを設定する。ここでは:nameと:family_nameの2つのキーを許可している
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :family_name])
  end
end
