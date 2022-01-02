class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :set_variables

  def set_variables
    @user ||= current_user
  end

  def user
    @user
  end

  def set_error(message, redirect: true, redirect_to: request.referer)
    set_message(message: message, variant: :alert, redirect: redirect, redirect_to: redirect_to)
  end

  def set_success(message, redirect: true, redirect_to: request.referer)
    set_message(message: message, variant: :notice, redirect: redirect, redirect_to: redirect_to)
  end

  def set_message(variant:, message:, redirect:, redirect_to: request.referer)
    flash[variant] = message
    return if !redirect
    redirect_to redirect_to
  end

  def t(key, **options)
    I18n.t(key, **options)
  end

  rescue_from ActionController::ParameterMissing do |e|
    parameter = e.param.to_s
    set_error(t('errors.parameter_required', parameter: parameter.gsub('_', ' ').capitalize))
  end
end
