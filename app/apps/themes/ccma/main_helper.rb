module Themes::Ccma::MainHelper
  def self.included(klass)
    klass.helper_method [:ccma_get_nav_menu, :ccma_lang, :ccma_translation] rescue ""
  end

  def ccma_settings(theme)
    # callback to save custom values of fields added in my_theme/views/admin/settings.html.erb
  end

  # callback called after theme installed
  def ccma_on_install_theme(theme)
    ccma_add_customize_theme_setting(theme)
    ccma_add_default_pages
    ccma_add_slider_post_type
    ccma_add_certificates_post_type
    ccma_add_activities_post_type
    ccma_add_fields_to_contact_us_page

  end

  def ccma_get_nav_menu(key = 'main_menu', class_name = "navigation")
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

  def ccma_lang
    if I18n.locale == :km
      'km'
    elsif I18n.locale == :cn
      'cn'
    else
      'en'
    end
  end

  def ccma_translation(khmer, english, chinese)
    ccma_lang == 'km' ? khmer : ccma_lang == 'cn' ? chinese : english
  end

  def ccma_add_default_pages
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

  def ccma_add_fields_to_contact_us_page
    page = current_site.the_post_type('page').the_post('contact-us')
    if page.get_field_groups.where(slug: 'contact-us-fields').blank?
      file_field_group = page.add_field_group({ name: 'Contact Us Fields', slug: 'contact-us-fields' }, 'Post')
      file_field_group.add_field({ name: 'Address', slug: 'address' },            { field_key: 'text_area', translate: true, required: true })
      file_field_group.add_field({ name: 'Phone number', slug: 'phone-number'},   { field_key: 'text_box',multiple: true, required: true})
      file_field_group.add_field({ name: 'Email', slug: 'email'},                 { field_key: 'text_box', required: true})
      file_field_group.add_field({ name: 'Embed Map Url', slug: 'embed-map-url'}, { field_key: 'text_box', required: true})
    end
  end

  def ccma_add_slider_post_type
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

  def ccma_add_certificates_post_type
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

  def ccma_add_activities_post_type
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

  def ccma_add_customize_theme_setting(theme)
      if theme.get_field_groups.where(slug: 'theme-setting').blank?
        group = theme.add_field_group({name: 'Theme Setting', slug: 'theme-setting'})
        group.add_field({ name: 'Ccma Logo', slug: 'ccma-logo' }, { field_key: 'image' })
        group.add_field({ name: 'Address', slug: 'address' }, { field_key: 'text_area', translate: true })
      end
    end
  # callback executed after theme uninstalled
  def ccma_on_uninstall_theme(theme)
  end
end
