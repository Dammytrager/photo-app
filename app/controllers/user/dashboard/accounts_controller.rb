class User::Dashboard::AccountsController < User::DashboardController

  before_action :validate_password_params, only: :update

  def index
  end

  def update
    password_params = @un_permitted_password_params.permit([:current_password, :password, :password_confirmation])

    if user.update_with_password(password_params)
      sign_in(user, :bypass => true)
      return set_success I18n.t('success.password_changed')
    end

    set_error user.errors&.full_messages.last
  end

  private

  def validate_password_params
    @un_permitted_password_params = params.require(:password)
    @un_permitted_password_params.require([:current_password, :password, :password_confirmation])
  end

end
