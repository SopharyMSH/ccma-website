module Themes::MainPage::MainHelper
  def self.included(klass)
    # klass.helper_method [:my_helper_method] rescue "" # here your methods accessible from views
  end

  def main_page_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  # callback called after theme installed
  def main_page_on_install_theme(theme)
    main_add_customize_theme_setting(theme)
  end

  def main_add_customize_theme_setting(theme)
    if theme.get_field_groups.where(slug: 'theme-setting').blank?
      group = theme.add_field_group({name: 'APCMGU', slug: 'apcmgu'})
      group.add_field({ name: 'Apcmgu Logo', slug: 'apcmgu-logo' }, { field_key: 'image', require: true })
      group.add_field({ name: 'Apcmgu Url', slug: 'apcmgu-url' }, { field_key: 'url', require: true })

      group = theme.add_field_group({name: 'CCMA', slug: 'ccma'})
      group.add_field({ name: 'Ccma Logo', slug: 'ccma-logo' }, { field_key: 'image', require: true })
      group.add_field({ name: 'Ccma Url', slug: 'ccma-url' }, { field_key: 'url', require: true })

      group = theme.add_field_group({name: 'Main Background', slug: 'main-background'})
      group.add_field({ name: 'Background-image', slug: 'background-image' }, { field_key: 'image' })
    end
  end

  # callback executed after theme uninstalled
  def ccma_on_uninstall_theme(theme)
  end
  # callback executed after theme uninstalled
  def main_page_on_uninstall_theme(theme)
  end
end
