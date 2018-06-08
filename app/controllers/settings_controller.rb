class SettingsController < ApplicationController
  before_action :require_admin

  def index
    @setting = Setting.first || Setting.new
    @admin_theme_setting = Setting.admin
  end

  def create
    @setting = Setting.first || Setting.new
    @setting.attributes= setting_params
    @setting.save


    if params[:logo]
      @company = Company.first || Company.new
      @company.avatar = params[:logo]
      @company.save
    end

    Setting['application_name'] = params['application_name']
    Setting['company_address'] = params['company_address']
    Setting['phone_number'] = params['phone_number']
    Setting['email_from'] = params['email_from']
    Setting['format_date'] = params['format_date']
    Setting['montant_timbre'] = params['montant_timbre'].to_i
    Setting['tva_location'] = params['tva_location'].to_i
    Setting['tva_vente'] = params['tva_vente'].to_i
    Setting['n_employeur'] = params['n_employeur'].to_s
    redirect_to settings_path
  end


  def set_user_auth
    Setting['whitelist_ip'] = params['whitelist_ip']
    Setting['blacklist_ip'] = params['blacklist_ip']
    Setting['user_default_state'] = params['user_default_state']
    Setting['remember_for'] = params['remember_for']
    Setting['timeout_in'] = params['timeout_in']
    Setting['maximum_attempts'] = params['maximum_attempts']
    Setting['unlock_in'] = params['unlock_in']
    Setting['expire_after'] = params['expire_after']
    Devise.setup do |config|
      config.remember_for = Setting['remember_for'].to_i.weeks
      config.timeout_in = Setting['timeout_in'].to_i.minutes
      config.maximum_attempts = Setting['maximum_attempts'].to_i
      config.unlock_in = Setting['unlock_in'].to_i.hour
      config.expire_after  = Setting['expire_after'].to_i.days
    end
    redirect_to settings_path
  end

  def set_theme
    theme = Setting.admin_theme
    hash = {
        theme_style: "#{params[:theme_style] ? params[:theme_style] : 'smart-style-0'}",
        header: "#{params[:header] ? 'fixed-header' : ''}",
        container: "#{params[:container] ? 'container' : ''}",
        footer: "#{params[:footer] ? 'fixed-page-footer' : ''}",
        topmenu: "#{params[:topmenu] ? 'menu-on-top' : '' }"
    }
    theme.value = hash.to_json
    theme.save

    redirect_to settings_path
  end

  private

  def setting_params
    params.require(:setting).permit(:home_page_content)
  end

end
