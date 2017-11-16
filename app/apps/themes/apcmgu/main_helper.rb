module Themes::Apcmgu::MainHelper
  def self.included(klass)
    klass.helper_method [:apcmgu_get_nav_menu, :apcmgu_lang, :apcmgu_translation] rescue ""
  end

  def apcmgu_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  # callback called after theme installed
  def apcmgu_on_install_theme(theme)
    apcmgu_add_customize_theme_setting(theme)
    apcmgu_add_default_pages
    apcmgu_add_slider_post_type
    apcmgu_add_certificates_post_type
    apcmgu_add_activities_post_type
    apcmgu_add_fields_to_contact_us_page
    apcmgu_add_fields_to_about_page

  end

  def apcmgu_get_nav_menu(key = 'main_menu', class_name = "navigation")
    option = {
      menu_slug: key,
      container_class: class_name,
      container_id: 'main-menu-ul',
      item_class_parent: 'dropdown',
      sub_class:        'dropdown-menu submenu-dropdown',
      callback_item: lambda do |args|
        args[:link_attrs] = "data-title='#{args[:link][:name].parameterize}'"
        if args[:has_children]
          args[:settings][:after] = "<span class='dropdown-icon'><i class='fa fa-angle-down' aria-hidden='true'></i></span>"
          args[:link_attrs] += "data-toggle='dropdown'"
        end
      end
    }
    draw_menu(option)
  end

  def apcmgu_lang
    if I18n.locale == :km
      'km'
    elsif I18n.locale == :cn
      'cn'
    else
      'en'
    end
  end

  def apcmgu_translation(khmer, english, chinese)
    apcmgu_lang == 'km' ? khmer : apcmgu_lang == 'cn' ? chinese : english
  end

  def apcmgu_add_default_pages
    page_post_type = current_site.the_post_type('page')
    if page_post_type.present?
      pages = ['Home','Contact Us','About']

      pages.each do |page|
        formatted_page = page.downcase.parameterize
        exist_page = current_site.the_post_type('page').the_posts.where("slug like '%#{formatted_page}%'")
        unless exist_page.present?
          page_post_type.add_post(title: page, content: 'lorem_ipsum')
        end
      end
    end
  end

  def apcmgu_add_fields_to_about_page
    page = current_site.the_post_type('page').the_post('about')
    if page.get_field_groups.where(slug: 'director-fields').blank?
      file_field_group = page.add_field_group({ name: 'Director Fields', slug: 'director-fields' }, 'Post')
      file_field_group.add_field({ name: 'Director Name', slug: 'director-name' },  { field_key: 'text_box', translate: true, required: true })
      file_field_group.add_field({ name: 'Director Image', slug: 'director-image'}, { field_key: 'image', required: true})
      file_field_group.add_field({ name: 'Director Title', slug: 'director-title'}, { field_key: 'text_box',translate: true, required: true})
    end
    if page.get_field_groups.where(slug: 'first-voice-director-fields').blank?
      file_field_group = page.add_field_group({ name: 'Voice-director Fields', slug: 'first-voice-director-fields' }, 'Post')
      file_field_group.add_field({ name: 'First Voice-director Name', slug: 'first-voice-director-name' },  { field_key: 'text_box', translate: true, required: true })
      file_field_group.add_field({ name: 'First Voice-director Image', slug: 'first-voice-director-image'}, { field_key: 'image', required: true})
      file_field_group.add_field({ name: 'First Voice-director Title', slug: 'first-voice-director-title'}, { field_key: 'text_box',translate: true, required: true})
    end
    if page.get_field_groups.where(slug: 'second-voice-director-fields').blank?
      file_field_group = page.add_field_group({ name: 'Voice-director Fields', slug: 'second-voice-director-fields' }, 'Post')
      file_field_group.add_field({ name: 'Second Voice-director Name', slug: 'second-voice-director-name' },  { field_key: 'text_box', translate: true, required: true })
      file_field_group.add_field({ name: 'Second Voice-director Image', slug: 'second-voice-director-image'}, { field_key: 'image', required: true})
      file_field_group.add_field({ name: 'Second Voice-director Title', slug: 'second-voice-director-title'}, { field_key: 'text_box',translate: true, required: true})
    end
    if page.get_field_groups.where(slug: 'third-voice-director-fields').blank?
      file_field_group = page.add_field_group({ name: 'Voice-director Fields', slug: 'third-voice-director-fields' }, 'Post')
      file_field_group.add_field({ name: 'Third Voice-director Name', slug: 'third-voice-director-name' },  { field_key: 'text_box', translate: true, required: true })
      file_field_group.add_field({ name: 'Third Voice-director Image', slug: 'third-voice-director-image'}, { field_key: 'image', required: true})
      file_field_group.add_field({ name: 'Third Voice-director Title', slug: 'third-voice-director-title'}, { field_key: 'text_box',translate: true, required: true})
    end
    if page.get_field_groups.where(slug: 'admin-fields').blank?
      file_field_group = page.add_field_group({ name: 'Admin Fields', slug: 'admin-fields' }, 'Post')
      file_field_group.add_field({ name: 'Admin Name', slug: 'admin-name' },  { field_key: 'text_box', translate: true, required: true })
      file_field_group.add_field({ name: 'Admin Image', slug: 'admin-image'}, { field_key: 'image', required: true})
      file_field_group.add_field({ name: 'Admin Title', slug: 'admin-title'}, { field_key: 'text_box',translate: true, required: true})
    end
    if page.get_field_groups.where(slug: 'the-finance-fields').blank?
      file_field_group = page.add_field_group({ name: 'The finance fields', slug: 'the-finance-fields' }, 'Post')
      file_field_group.add_field({ name: 'The finance Name', slug: 'the-finance-name' },  { field_key: 'text_box', translate: true, required: true })
      file_field_group.add_field({ name: 'The finance Image', slug: 'the-finance-image'}, { field_key: 'image', required: true})
      file_field_group.add_field({ name: 'The finance Title', slug: 'the-finance-title'}, { field_key: 'text_box',translate: true, required: true})
    end
    if page.get_field_groups.where(slug: 'the-program-preparing-fields').blank?
      file_field_group = page.add_field_group({ name: 'The program preparing Fields', slug: 'the-program-preparing-fields' }, 'Post')
      file_field_group.add_field({ name: 'The program preparing Name', slug: 'the-program-preparing-name' },  { field_key: 'text_box', translate: true, required: true })
      file_field_group.add_field({ name: 'The program preparing Image', slug: 'the-program-preparing-image'}, { field_key: 'image', required: true})
      file_field_group.add_field({ name: 'The program preparing Title', slug: 'the-program-preparing-title'}, { field_key: 'text_box',translate: true, required: true})
    end

  end

  def apcmgu_add_fields_to_contact_us_page
    page = current_site.the_post_type('page').the_post('contact-us')
    if page.get_field_groups.where(slug: 'contact-us-fields').blank?
      file_field_group = page.add_field_group({ name: 'Contact Us Fields', slug: 'contact-us-fields' }, 'Post')
      file_field_group.add_field({ name: 'Address', slug: 'address' },            { field_key: 'text_area', translate: true, required: true })
      file_field_group.add_field({ name: 'Phone number', slug: 'phone-number'},   { field_key: 'text_box',multiple: true, required: true})
      file_field_group.add_field({ name: 'Email', slug: 'email'},                 { field_key: 'text_box', required: true})
      file_field_group.add_field({ name: 'Embed Map Url', slug: 'embed-map-url'}, { field_key: 'text_box', required: true})
    end
  end

  def apcmgu_add_slider_post_type
    if current_site.the_post_type('home-slider').blank?
      sliders = current_site.post_types.create(name: 'Home Slider', slug: 'home-slider')
      options = {
        has_category: false,
        has_content: false,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      sliders.set_meta('_default', options)
      if sliders.get_field_groups.where(slug: 'home-slider').blank?
        sliders_field_group = sliders.add_field_group({ name: 'Home Slider', slug: 'home-slider' } )

        sliders_field_group.add_field({ name: 'Slide Image', slug: 'slide-image' }, { field_key: 'image', required: true } )
        sliders_field_group.add_field({ name: 'Description', slug: 'description' }, { field_key: 'text_box', required: true, translate: true } )
      end
    end
  end

  def apcmgu_add_certificates_post_type
    if current_site.the_post_type('certificates').blank?
      certificates = current_site.post_types.create(name: 'Certificates', slug: 'certificates')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      certificates.set_meta('_default', options)
      if certificates.get_field_groups.where(slug: 'Certificates field').blank?
        certificates_field_group = certificates.add_field_group({ name: 'Certificates field', slug: 'certificates-field' } )

        certificates_field_group.add_field({ name: 'Image', slug: 'image' }, { field_key: 'image', required: true } )
      end
    end
  end

  def apcmgu_add_activities_post_type
    if current_site.the_post_type('activities').blank?
      activities = current_site.post_types.create(name: 'Activities', slug: 'activities')
      options = {
        has_category: false,
        has_content: true,
        has_tags: false,
        has_summary: false,
        has_comments: false,
        has_picture: false,
        has_template: false,
        has_keywords: false,
        contents_route_format: 'post_of_posttype'
      }
      activities.set_meta('_default', options)
      if activities.get_field_groups.where(slug: 'Activities field').blank?
        activities_field_group = activities.add_field_group({ name: 'Activities field', slug: 'activities-field' } )

        activities_field_group.add_field({ name: 'Image Introduction', slug: 'image-introduction' }, { field_key: 'image', required: true } )
      end
    end
  end

  def apcmgu_add_customize_theme_setting(theme)
      if theme.get_field_groups.where(slug: 'theme-setting').blank?
        group = theme.add_field_group({name: 'Theme Setting', slug: 'theme-setting'})
        group.add_field({ name: 'APCMGU Logo', slug: 'apcmgu-logo' }, { field_key: 'image' })
        group.add_field({ name: 'Address', slug: 'address' }, { field_key: 'text_area', translate: true })
      end
    end
  # callback executed after theme uninstalled
  def apcmgu_on_uninstall_theme(theme)
  end
end
